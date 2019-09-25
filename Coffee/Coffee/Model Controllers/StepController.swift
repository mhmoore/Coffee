//
//  StepController.swift
//  Coffee
//
//  Created by Michael Moore on 9/24/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class StepController {
    
    
    static func createStep(guide: Guide, title: String, water: Double?, time: TimeInterval, text: String) {
        let newStep = Step(title: title, water: water, time: time, text: text)
        GuideController.shared.add(step: newStep, guide: guide)
    }
    
    static func update(step: Step, guide: Guide, title: String?, water: Double?, time: TimeInterval?, text: String?) {
        guard let title = title,
            let water = water,
            let time = time,
            let text = text else { return }
        step.title = title
        step.water = water
        step.time = time
        step.text = text
    }
}
