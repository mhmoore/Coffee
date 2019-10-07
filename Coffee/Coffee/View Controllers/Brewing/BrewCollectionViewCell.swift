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
    @IBOutlet weak var methodImage: UIImageView!
    @IBOutlet weak var methodNameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
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
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    func setupUI() {
        deleteButton.backgroundColor = .accent
        deleteButton.layer.cornerRadius = deleteButton.bounds.width / 2.0
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
