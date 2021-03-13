//
//  BrewCollectionViewCell.swift
//  Coffee
//
//  Created by Michael Moore on 9/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

protocol BrewCellDelegate: class {
    func delete(cell: BrewCollectionViewCell)
}

class BrewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var methodImage: UIImageView!
    @IBOutlet weak var methodNameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: BrewCellDelegate?
    
    var guide: Guide? {
        didSet {
            setupUI()
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            if guide?.userGuide == true {
                deleteButton.isHidden = !isEditing
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    // MARK: - Custom Methods
    func setupUI() {
        deleteButton.backgroundColor = .clear
        deleteButton.layer.masksToBounds = true
        deleteButton.isHidden = true
        
        guard let guide = guide else { return }
        methodNameLabel?.text = guide.title
        switch guide.method {
        case BrewKeys.chemexKey:
            methodImage?.image = UIImage(named: AssetKeys.chemexKey)
        case BrewKeys.aeroPressKey:
            methodImage?.image = UIImage(named: AssetKeys.aeroPressKey)
        case BrewKeys.frenchPressKey:
            methodImage?.image = UIImage(named: AssetKeys.frenchPressKey)
        case BrewKeys.kalitaKey:
            methodImage?.image = UIImage(named: AssetKeys.kalitaKey)
        case BrewKeys.v60Key:
            methodImage?.image = UIImage(named: AssetKeys.v60Key)
        default:
            methodImage?.image = nil
        }
    }
}
