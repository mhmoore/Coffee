//
//  Step.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import UIKit.UIImage

class Step: Codable {
    var title: String
    var water: Double?
    var time: TimeInterval?
    var text: String
    
    init(title: String, water: Double?, time: TimeInterval?, text: String) {
        self.title = title
        self.water = water
        self.time = time
        self.text = text
    }
}

extension Step: Equatable {
    static func == (lhs: Step, rhs: Step) -> Bool {
        return lhs.title == rhs.title &&
                lhs.water == rhs.water &&
                lhs.time == rhs.time &&
                lhs.text == rhs.text
    }
}

