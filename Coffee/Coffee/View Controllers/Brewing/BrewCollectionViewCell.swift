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
    @IBOutlet weak var methodImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    weak var delegate: BrewCellDelegate?
    
    var guide: Guide? {
        didSet {
            guard let guide = guide else { return }
            titleLabel?.text = guide.title
            switch guide.method {
            case BrewKeys.chemexKey:
                methodImageView?.image = UIImage(named: AssetKeys.chemexKey)
            case BrewKeys.aeroPressKey:
                methodImageView?.image = UIImage(named: AssetKeys.aeroPressKey)
            case BrewKeys.frenchPressKey:
                methodImageView?.image = UIImage(named: AssetKeys.frenchPressKey)
            case BrewKeys.kalitaKey:
                methodImageView?.image = UIImage(named: AssetKeys.kalitaKey)
            case BrewKeys.v60Key:
                methodImageView?.image = UIImage(named: AssetKeys.v60Key)
            default:
                methodImageView?.image = nil
            }
            
            deleteButton.layer.cornerRadius = deleteButton.bounds.width / 2.0
            deleteButton.layer.masksToBounds = true
            deleteButton.isHidden = true
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
}
