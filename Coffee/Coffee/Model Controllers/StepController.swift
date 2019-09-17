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
    
    func createStep(time: TimeInterval?, amount: Double?, type: StepType) -> Step {
        guard let time = time,
            let amount = amount else { return Step(time: 0, amount: 0, type: .pour) } // TODO: I don't think this is right
        let newStep = Step(time: time, amount: amount, type: type)
        steps.append(newStep)
        return newStep
    }
    
    func stepsAsStrings(steps: [Step]) -> [String] {
        var stepStrings: [String] = []
        for step in steps {
            guard let amount = step.amount, let time = step.time else { return [] }
            if step.type == .pour {
                let pourStep = "Pour \(amount)g over \(time) seconds"
                stepStrings.append(pourStep)
            } else if step.type == .stir {
                let stirStep = "Stir for \(time) seconds"
                stepStrings.append(stirStep)
            } else {
                let waitStep = "Wait for \(time) seconds"
                stepStrings.append(waitStep)
            }
        }
        return stepStrings
    }
    
    func update(step: Step, time: TimeInterval?, amount: Double?, type: StepType) {
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
