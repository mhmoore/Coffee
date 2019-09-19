//
//  Guide.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import CloudKit
import UIKit.UIImage

struct GuideKeys {
    
    static let GuideKey = "Category"
    static let titleKey = "Title"
    static let grindKey = "Grind"
    static let coffeeKey = "Coffee"
    static let prepKey = "Prep"
    static let stepsKey = "Steps"
    static let methodKey = "Method"
    static let methodInfoKey = "MethodInfo"
    static let methodImageKey = "MethodImage"
    static let typeKey = "Guide"
}

class Guide {
    
    var userGuide: Bool
    var title: String
    var grind: String
    var coffee: Double
    var totalWater: Double {
        var total: Double = 0
        for step in steps {
            if let amountOfWater = step.amountOfWater {
                total += amountOfWater
            }
        }
        return total
    }
    var prep: String
    var steps: [Step]
    var method: String
    var methodInfo: String
    var methodImage: UIImage
    var totalTime: TimeInterval {
        var total: TimeInterval = 0.0
        for step in steps {
            total += step.duration
        }
        return total
    }
    var ckRecordID: CKRecord.ID?
    
    init(userGuide: Bool, title: String, grind: String, coffee: Double, prep: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage) {
        self.userGuide = userGuide
        self.title = title
        self.grind = grind
        self.coffee = coffee
        self.prep = prep
        self.steps = steps
        self.method = method
        self.methodInfo = methodInfo
        self.methodImage = methodImage
    }
}

extension Guide: Equatable {
    static func == (lhs: Guide, rhs: Guide) -> Bool {
        return lhs.userGuide == rhs.userGuide &&
            lhs.title == rhs.title &&
            lhs.grind == rhs.grind &&
            lhs.coffee == rhs.coffee &&
            lhs.prep == rhs.prep &&
            lhs.steps == rhs.steps &&
            lhs.method == rhs.method &&
            lhs.methodInfo == rhs.methodInfo &&
            lhs.methodImage == rhs.methodImage
    }
}

// Save BrewGuide object to iCloud
extension CKRecord {
    convenience init(brewGuide: Guide) {
        let recordID = brewGuide.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: GuideKeys.typeKey, recordID: recordID)
        self.setValue(brewGuide.userGuide, forKey: GuideKeys.GuideKey)
        self.setValue(brewGuide.title, forKey: GuideKeys.titleKey)
        self.setValue(brewGuide.grind, forKey: GuideKeys.grindKey)
        self.setValue(brewGuide.coffee, forKey: GuideKeys.coffeeKey)
        self.setValue(brewGuide.prep, forKey: GuideKeys.prepKey)
        self.setValue(brewGuide.steps, forKey: GuideKeys.stepsKey)
        self.setValue(brewGuide.method, forKey: GuideKeys.methodKey)
        self.setValue(brewGuide.methodInfo, forKey: GuideKeys.methodInfoKey)
        self.setValue(brewGuide.methodImage, forKey: GuideKeys.methodImageKey)
        brewGuide.ckRecordID = recordID
    }
}

// Initializes BrewGuide object from iCloud
extension Guide {
    convenience init?(record: CKRecord) {
        guard let userGuide = record[GuideKeys.GuideKey] as? Bool,
            let title = record[GuideKeys.titleKey] as? String,
            let grind = record[GuideKeys.grindKey] as? String,
            let coffee = record[GuideKeys.coffeeKey] as? Double,
            let prep = record[GuideKeys.prepKey] as? String,
            let steps = record[GuideKeys.stepsKey] as? [Step],
            let method = record[GuideKeys.methodKey] as? String,
            let methodInfo = record[GuideKeys.methodInfoKey] as? String,
            let methodImage = record[GuideKeys.methodImageKey] as? UIImage else { return nil }
        self.init(userGuide: userGuide, title: title, grind: grind, coffee: coffee, prep: prep, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage)
        ckRecordID = record.recordID
    }
}
