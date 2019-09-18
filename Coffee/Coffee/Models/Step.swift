//
//  Step.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class Step {
    
    var time: String
    var amount: String?
    var type: StepType
    
    init(time: String, amount: String?, type: StepType) {
        self.time = time
        self.amount = amount
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
        return  lhs.time == rhs.time &&
                lhs.amount == rhs.amount &&
                lhs.type == rhs.type
    }
}
