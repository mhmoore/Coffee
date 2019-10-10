//
//  CustomStepTableViewCell.swift
//  Coffee
//
//  Created by Michael Moore on 10/5/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class CustomStepTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepView: UIView!
    
    // MARK: - Properties
    var step: Step? {
        didSet {
            stepLabel.textAlignment = .center
            stepLabel.text = step?.text
            stepView.backgroundColor = .textFieldBackground
        }
    }
}
