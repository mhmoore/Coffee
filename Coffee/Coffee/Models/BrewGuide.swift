//
//  UserGuide.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import CloudKit
import UIKit.UIImage

struct BrewGuideKeys {
    
    static let userGuideKey = "Category"
    static let titleKey = "Title"
    static let grindKey = "Grind"
    static let coffeeAmountKey = "CoffeeAmount"
    static let waterAmountKey = "WaterAmount"
    static let prepKey = "Prep"
    static let stepsKey = "Steps"
    static let methodKey = "Method"
    static let methodInfoKey = "MethodInfo"
    static let methodImageKey = "MethodImage"
    static let timeKey = "Time"
    static let timestampKey = "Timestamp"
    static let typeKey = "BrewGuide"
}

class BrewGuide {
    
    var userGuide: Bool
    var title: String
    var grind: String
    var coffeeAmount: String
    var waterAmount: String
    var prep: String
    var steps: [Step]
    var method: String
    var methodInfo: String
    var methodImage: UIImage
    var time: String
    var ckRecordID: CKRecord.ID?
    
    init(userGuide: Bool, title: String, grind: String, coffeeAmount: String, waterAmount: String, prep: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage, time: String) {
        self.userGuide = userGuide
        self.title = title
        self.grind = grind
        self.coffeeAmount = coffeeAmount
        self.waterAmount = waterAmount
        self.prep = prep
        self.steps = steps
        self.method = method
        self.methodInfo = methodInfo
        self.methodImage = methodImage
        self.time = time
    }
}

extension BrewGuide: Equatable {
    static func == (lhs: BrewGuide, rhs: BrewGuide) -> Bool {
        return lhs.userGuide == rhs.userGuide &&
            lhs.title == rhs.title &&
            lhs.grind == rhs.grind &&
            lhs.coffeeAmount == rhs.coffeeAmount &&
            lhs.waterAmount == rhs.waterAmount &&
            lhs.prep == rhs.prep &&
            lhs.steps == rhs.steps &&
            lhs.method == rhs.method &&
            lhs.methodInfo == rhs.methodInfo &&
            lhs.methodImage == rhs.methodImage &&
            lhs.time == rhs.time
    }
}

// Save BrewGuide object to iCloud
extension CKRecord {
    convenience init(brewGuide: BrewGuide) {
        let recordID = brewGuide.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: BrewGuideKeys.typeKey, recordID: recordID)
        self.setValue(brewGuide.userGuide, forKey: BrewGuideKeys.userGuideKey)
        self.setValue(brewGuide.title, forKey: BrewGuideKeys.titleKey)
        self.setValue(brewGuide.grind, forKey: BrewGuideKeys.grindKey)
        self.setValue(brewGuide.coffeeAmount, forKey: BrewGuideKeys.coffeeAmountKey)
        self.setValue(brewGuide.waterAmount, forKey: BrewGuideKeys.waterAmountKey)
        self.setValue(brewGuide.prep, forKey: BrewGuideKeys.prepKey)
        self.setValue(brewGuide.steps, forKey: BrewGuideKeys.stepsKey)
        self.setValue(brewGuide.method, forKey: BrewGuideKeys.methodKey)
        self.setValue(brewGuide.methodInfo, forKey: BrewGuideKeys.methodInfoKey)
        self.setValue(brewGuide.methodImage, forKey: BrewGuideKeys.methodImageKey)
        self.setValue(brewGuide.time, forKey: BrewGuideKeys.timeKey)
        brewGuide.ckRecordID = recordID
    }
}

// Initializes BrewGuide object from iCloud
extension BrewGuide {
    convenience init?(record: CKRecord) {
        guard let userGuide = record[BrewGuideKeys.userGuideKey] as? Bool,
            let title = record[BrewGuideKeys.titleKey] as? String,
            let grind = record[BrewGuideKeys.grindKey] as? String,
            let coffeeAmount = record[BrewGuideKeys.coffeeAmountKey] as? String,
            let waterAmount = record[BrewGuideKeys.waterAmountKey] as? String,
            let prep = record[BrewGuideKeys.prepKey] as? String,
            let steps = record[BrewGuideKeys.stepsKey] as? [Step],
            let method = record[BrewGuideKeys.methodKey] as? String,
            let methodInfo = record[BrewGuideKeys.methodInfoKey] as? String,
            let methodImage = record[BrewGuideKeys.methodImageKey] as? UIImage,
            let time = record[BrewGuideKeys.timeKey] as? String else { return nil }
        self.init(userGuide: userGuide, title: title, grind: grind, coffeeAmount: coffeeAmount, waterAmount: waterAmount, prep: prep, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage, time: time)
        ckRecordID = record.recordID
    }
}
