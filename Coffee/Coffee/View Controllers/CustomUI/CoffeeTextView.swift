//
//  CoffeeTextView.swift
//  Coffee
//
//  Created by Michael Moore on 10/6/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class CoffeeTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont(to: FontKeys.monteserratKey)
        setupUI()
    }
    
    func setFont(to fontName: String) {
        guard let size = font?.pointSize else { return }
        font = UIFont(name: fontName, size: size)
    }
    
    func setupUI() {
        textColor = .generalType
        backgroundColor = .textFieldBackground
        tintColor = .accent
        addAccentBorder()
        addCornerRadius(8)
        layer.masksToBounds = true
    }
    
}
