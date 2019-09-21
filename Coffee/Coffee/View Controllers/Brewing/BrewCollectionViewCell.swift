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
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var deleteBackgroundView: UIVisualEffectView!
    
    weak var delegate: BrewCellDelegate?
    var guide: Guide? {
        didSet {
            methodImageView.image = guide?.methodImage
            methodLabel.text = guide?.method
            deleteBackgroundView.layer.cornerRadius = deleteBackgroundView.frame.height / 2
//            deleteBackgroundView.layer.masksToBounds = true
            deleteBackgroundView.isHidden = true
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            deleteBackgroundView.isHidden = isEditing
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
}
