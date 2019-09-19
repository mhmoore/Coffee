//
//  Step.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class Step {
    
    var duration: TimeInterval
    var amountOfWater: Double?
    var type: StepType
    
    init(duration: TimeInterval, amount: Double?, type: StepType) {
        self.duration = duration
        self.amountOfWater = amount
        self.type = type
    }
}

enum StepType: Int {
    case pour
    case stir
    case wait
}

extension Step: Equatable {
    static func == (lhs: Step, rhs: Step) -> Bool {
        return  lhs.duration == rhs.duration &&
                lhs.amountOfWater == rhs.amountOfWater &&
                lhs.type == rhs.type
    }
}
