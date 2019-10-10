//
//  InstructionStepTableViewCell.swift
//  Coffee
//
//  Created by Michael Moore on 10/5/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class InstructionStepTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepView: UIView!
    
    // MARK: - Properties
    var step: Step? {
        didSet {
            stepLabel.text = step?.text
            stepLabel.textAlignment = .center
            stepView.backgroundColor = .textFieldBackground
        }
    }
}
