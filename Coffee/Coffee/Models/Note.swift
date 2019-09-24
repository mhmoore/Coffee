//
//  Note.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class Note: Codable {
    
    var roaster: String
    var coffeeName: String
    var origin: String
    var grind: String
    var ratio: String
    var method: String
    var tastingNotes: String
    
    init(roaster: String, coffeeName: String, origin: String, grind: String, ratio: String, method: String, tastingNotes: String) {
        self.roaster = roaster
        self.coffeeName = coffeeName
        self.origin = origin
        self.grind = grind
        self.ratio = ratio
        self.method = method
        self.tastingNotes = tastingNotes
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return  lhs.roaster == rhs.roaster &&
            lhs.coffeeName == rhs.coffeeName &&
            lhs.method == rhs.method &&
            lhs.origin == rhs.origin &&
            lhs.tastingNotes == rhs.tastingNotes &&
            lhs.ratio == rhs.ratio &&
            lhs.grind == rhs.grind
    }
}
