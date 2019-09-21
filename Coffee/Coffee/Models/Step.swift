//
//  Step.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import UIKit.UIImage

class Step {
    var title: String
    var water: Double?
    var time: TimeInterval?
    var coffee: Double?
    var text: String
    var timerLabel: Bool
    var variableSlider: Bool
    
    init(title: String, water: Double?, time: TimeInterval?, coffee: Double?, text: String, timerLabel: Bool, variableSlider: Bool) {
        self.title = title
        self.water = water
        self.time = time
        self.coffee = coffee
        self.text = text
        self.timerLabel = timerLabel
        self.variableSlider = variableSlider
    }
}

extension Step: Equatable {
    static func == (lhs: Step, rhs: Step) -> Bool {
        return lhs.title == rhs.title &&
                lhs.water == rhs.water &&
                lhs.time == rhs.time &&
                lhs.timerLabel == rhs.timerLabel &&
                lhs.variableSlider == rhs.variableSlider &&
                lhs.coffee == rhs.coffee &&
                lhs.text == rhs.text
    }
}

