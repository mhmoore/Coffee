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
            case "CHEMEX":
                methodImageView?.image = UIImage(named: "chemex")
            case "AeroPress":
                methodImageView?.image = UIImage(named: "aeroPress")
            case "Moka Pot":
                methodImageView?.image = UIImage(named: "mokaPot")
            case "French Press":
                methodImageView?.image = UIImage(named: "frenchPress")
            case "Kalita Wave":
                methodImageView?.image = UIImage(named: "kalita")
            case "Hario V60" :
                methodImageView?.image = UIImage(named: "v60")
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
