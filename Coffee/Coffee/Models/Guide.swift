//
//  Guide.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

struct GrindKeys {
    
    static let fineKey = "Fine"
    static let fineMediumKey = "Fine-Medium"
    static let mediumKey = "Medium"
    static let mediumCoarseKey = "Medium-Coarse"
    static let coarseKey = "Coarse"
    static let extraCoarseKey = "Extra Coarse"
}

struct BrewKeys {
    
    static let v60Key = "HARIO V60"
    static let frenchPressKey = "French Press"
    static let kalitaKey = "Kalita Wave"
    static let chemexKey = "CHEMEX"
    static let aeroPressKey = "AeroPress"
    
}

class Guide: Codable {
    
    var userGuide: Bool
    var title: String
    var method: String
    var methodInfo: String
    var coffee: Double
    var grind: String
    var prep: String
    var steps: [Step]
    var notes: [Note]
    
    init(userGuide: Bool, title: String, method: String, methodInfo: String, coffee: Double, grind: String, prep: String, steps: [Step], notes: [Note] = []) {
        self.userGuide = userGuide
        self.title = title
        self.method = method
        self.methodInfo = methodInfo
        self.coffee = coffee
        self.grind = grind
        self.prep = prep
        self.steps = steps
        self.notes = notes
    }
}

extension Guide: Equatable {
    static func == (lhs: Guide, rhs: Guide) -> Bool {
        return lhs.userGuide == rhs.userGuide &&
            lhs.title == rhs.title &&
            lhs.method == rhs.method &&
            lhs.methodInfo == rhs.methodInfo &&
            lhs.coffee == rhs.coffee &&
            lhs.grind == rhs.grind &&
            lhs.prep == rhs.prep &&
            lhs.steps == rhs.steps &&
            lhs.notes == rhs.notes
    }
}
