//
//  CoffeeLabel.swift
//  Coffee
//
//  Created by Michael Moore on 10/6/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class CoffeeLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont(to: FontKeys.norwesterKey)
        textColor = .generalType
        addCornerRadius(4)
    }
    
    func setFont(to fontName: String) {
        let size = font.pointSize
        self.font = UIFont(name: fontName, size: size)
    }
}

class titleLabel: CoffeeLabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont(to: FontKeys.kollektifKey)
        textColor = .generalType
    }
}

class descriptionLabel: CoffeeLabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont(to: FontKeys.monteserratKey)
        textColor = .generalType
    }
}
