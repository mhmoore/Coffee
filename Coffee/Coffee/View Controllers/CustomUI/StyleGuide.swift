//
//  StyleGuide.swift
//  Coffee
//
//  Created by Michael Moore on 9/28/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4) {
           layer.cornerRadius = radius
    }
    
    func addAccentBorder(width: CGFloat = 1, color: UIColor = .border) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

struct AssetKeys {
    // brewing method images
    static let v60Key = "v60"
    static let frenchPressKey = "frenchPress"
    static let kalitaKey = "kalita"
    static let chemexKey = "chemex"
    static let aeroPressKey = "aeroPress"
    // grind images
    static let fineKey = "fine"
    static let fineMediumKey = "fineMedium"
    static let mediumKey = "medium"
    static let mediumCoarseKey = "mediumCoarse"
    static let coarseKey = "coarse"
    static let extraCoarseKey = "extraCoarse"
    // steps icons
    static let pourKey = "water"
    static let stirKey = "spoon"
    static let waitKey = "time"
    static let otherKey = "other"
}

struct FontKeys {
    static let norwesterKey = "Norwester"
    static let monteserratKey = "Montserrat-Light"
    static let kollektifKey = "Kollektif"
}

extension UIColor {
    static let background = UIColor(named: "background") ?? .lightGray
    static let accent = UIColor(named: "accent") ?? .darkGray
    static let buttonType = UIColor(named: "buttonType") ?? .white
    static let generalType = UIColor(named: "generalType") ?? .black
    static let border = UIColor(named: "border") ?? .darkGray
    static let textFieldBackground = UIColor(named: "textfieldBackground") ?? .white
}

