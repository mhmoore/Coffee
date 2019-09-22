//
//  BrewCollectionViewCell.swift
//  Coffee
//
//  Created by Michael Moore on 9/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class BrewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var methodImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var guide: Guide?
}
