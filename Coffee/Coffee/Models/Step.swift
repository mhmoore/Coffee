//
//  Step.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class Step {
    
    var time: TimeInterval?
    var amount: Double?
    var type: StepType
    
    init(time: TimeInterval, amount: Double, type: StepType) {
        self.time = time
        self.amount = amount
        self.type = type
    }
}

enum StepType {
    case pour
    case stir
    case wait
}

extension Step: Equatable {
    static func == (lhs: Step, rhs: Step) -> Bool {
        return  lhs.time == rhs.time &&
                lhs.amount == rhs.amount &&
                lhs.type == rhs.type
    }
}
