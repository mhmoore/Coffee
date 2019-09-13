//
//  BrewGuide.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class BrewGuide {
    
    let grind: String
    let coffeeAmount: Double
    let waterAmount: Double
    let steps: [String]
    let method: String
    
    init(grind: String, coffeeAmount: Double, waterAmount: Double, steps: [String], method: String) {
        self.grind = grind
        self.coffeeAmount = coffeeAmount
        self.waterAmount = waterAmount
        self.steps = steps
        self.method = method
    }
}
