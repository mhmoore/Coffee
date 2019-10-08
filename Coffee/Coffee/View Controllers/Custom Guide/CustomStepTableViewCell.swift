//
//  CustomStepTableViewCell.swift
//  Coffee
//
//  Created by Michael Moore on 10/5/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class CustomStepTableViewCell: UITableViewCell {
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepView: UIView!
    
    var step: Step? {
        didSet {
            stepLabel.textAlignment = .center
            stepLabel.text = step?.text
            stepView.backgroundColor = .textFieldBackground
        }
    }
}
