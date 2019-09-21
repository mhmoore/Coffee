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
        
        let title1 = "Weigh"
        let water1 = 0.0
        let time1 = 0.0
        let coffee1 = 20.0
        let text1 = "hdjskafo"
        
        createStep(title: title1, water: water1, time: time1, coffee: coffee1, text: text1)
        
        let title = "Pour"
        let water = 150.0
        let time = 10.0
        let coffee = 0.0
        let text = "hdjskafo"
        
        createStep(title: title, water: water, time: time, coffee: coffee, text: text)
    }
    
    func createStep(title: String, water: Double?, time: TimeInterval?, coffee: Double?, text: String) {
        guard let time = time else { return }
        if water != 0.0 {
            let newStep = Step(title: title, water: water, time: time, coffee: coffee, text: text, timerLabel: true, variableSlider: false)
            steps.append(newStep)
        } else if coffee != 0.0 {
            let newStep = Step(title: title, water: water, time: time, coffee: coffee, text: text, timerLabel: false, variableSlider: true)
            steps.append(newStep)
        } else {
            let newStep = Step(title: title, water: water, time: time, coffee: coffee, text: text, timerLabel: true, variableSlider: false)
            steps.append(newStep)
        }
    }
    
    func update(step: Step, title: String?, water: Double?, time: TimeInterval?, coffee: Double?, text: String?) {
        guard let title = title, let text = text else { return }
        if water != nil {
            step.title = title
            step.water = water
            step.time = time
            step.coffee = coffee
            step.text = text
            step.timerLabel = true
            step.variableSlider = false
        } else if coffee != nil {
            step.title = title
            step.water = water
            step.time = time
            step.coffee = coffee
            step.text = text
            step.timerLabel = false
            step.variableSlider = true
        } else {
            step.title = title
            step.water = water
            step.time = time
            step.coffee = coffee
            step.text = text
            step.timerLabel = true
            step.variableSlider = false
        }
    }
    
    func remove(step: Step) {
        guard let index = steps.firstIndex(of: step) else { return }
        steps.remove(at: index)
    }
    
}
