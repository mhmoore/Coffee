//
//  StepController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class StepController {
    
    static let shared = StepController()
    var steps: [Step] = []
    
    init() {
        let time = 20
        let amount = 120
        let type = StepType.pour
        
        let chemexStep: Step = Step(time: String(time), amount: String(amount), type: type)
        
        steps = [chemexStep]
    }
    
    func createStep(time: String, amount: String?, type: StepType) -> Step {
        let newStep = Step(time: time, amount: amount, type: type)
        steps.append(newStep)
        return newStep
    }
    
    func stepsAsStrings(steps: [Step]) -> [String] {
        var stepStrings: [String] = []
        for step in steps {
            if let amount = step.amount {
                if step.type == .pour {
                    let pourStep = "Pour \(amount)g of water over \(step.time) seconds"
                    stepStrings.append(pourStep)
                }
            } else if step.type == .stir {
                let stirStep = "Stir for \(step.time) seconds"
                stepStrings.append(stirStep)
            } else {
                let waitStep = "Wait for \(step.time) seconds"
                stepStrings.append(waitStep)
            }
            
        }
        return stepStrings
    }
    
    func update(step: Step, time: String?, amount: String?, type: StepType) {
        guard let time = time, let amount = amount else { return }
        step.time = time
        step.amount = amount
        step.type = type
    }
    
    func delete(step: Step) {
        guard let index = steps.firstIndex(of: step) else { return }
        steps.remove(at: index)
    }
}
