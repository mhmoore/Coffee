//
//  ActionButton.swift
//  Coffee
//
//  Created by Michael Moore on 10/6/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFont(to: FontKeys.kollektifKey)
        setupUI()
    }

    func setFont(to fontName: String) {
        guard let size = titleLabel?.font.pointSize else { return }
        self.titleLabel?.font = UIFont(name: fontName, size: size)
    }

    func setupUI() {
        backgroundColor = .accent
        setTitleColor(.buttonType, for: .normal)
        addCornerRadius(8)
        addAccentBorder()
    }
    
}
