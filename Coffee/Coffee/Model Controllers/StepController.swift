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
        let duration = 5
        let amount = 120.0
        let type = StepType.pour
        
        let duration3 = 3
        let amount3 = 10.0
        let type3 = StepType.pour
        
        let duration2 = 7
        let type2 = StepType.stir
        
        let chemexStep3: Step = Step(duration: TimeInterval(duration3), amount: amount3, type: type3, stepString:)
        let chemexStep1: Step = Step(duration: TimeInterval(duration), amount: amount, type: type)
        let chemexStep2: Step = Step(duration: TimeInterval(duration2), amount: nil, type: type2)
        
        steps = [chemexStep1, chemexStep2, chemexStep3]
    }
    
    func createStep(time: TimeInterval, amount: Double?, type: StepType) -> Step {
        let newStep = Step(duration: time, amount: amount, type: type)
        steps.append(newStep)
        return newStep
    }
    
    func stepsAsStrings(steps: [Step]) -> [String] {
        var stepStrings: [String] = []
        for step in steps {
            if let amount = step.amountOfWater {
                if step.type == .pour {
                    let pourStep = "Pour \(amount)g of water over \(step.duration) seconds"
                    stepStrings.append(pourStep)
                }
            } else if step.type == .stir {
                let stirStep = "Stir for \(step.duration) seconds"
                stepStrings.append(stirStep)
            } else {
                let waitStep = "Wait for \(step.duration) seconds"
                stepStrings.append(waitStep)
            }
            
        }
        return stepStrings
    }
    
    func update(step: Step, time: TimeInterval?, amount: Double?, type: StepType) {
        guard let time = time, let amount = amount else { return }
        step.duration = time
        step.amountOfWater = amount
        step.type = type
    }
    
    func delete(step: Step) {
        guard let index = steps.firstIndex(of: step) else { return }
        steps.remove(at: index)
    }
}
