//
//  UserGuide.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import CloudKit

struct UserGuideKeys {
    
    static let titleKey = "Title"
    static let grindKey = "Grind"
    static let coffeeAmountKey = "CoffeeAmount"
    static let waterAmountKey = "WaterAmount"
    static let stepsKey = "Steps"
    static let methodKey = "Method"
    static let timeKey = "Time"
    static let timestampKey = "Timestamp"
    static let typeKey = "UserGuide"
}

class UserGuide {
    
    var title: String
    var grind: String
    var coffeeAmount: Double
    var waterAmount: Double
    var steps: [String]
    var method: String
    var time: Date
    var timestamp: Date
    var ckRecordID: CKRecord.ID?
    
    init(title: String, grind: String, coffeeAmount: Double, waterAmount: Double, steps: [String], method: String, time: Date, timestamp: Date = Date()) {
        self.title = title
        self.grind = grind
        self.coffeeAmount = coffeeAmount
        self.waterAmount = waterAmount
        self.steps = steps
        self.method = method
        self.time = time
        self.timestamp = timestamp
    }
}

extension UserGuide: Equatable {
    static func == (lhs: UserGuide, rhs: UserGuide) -> Bool {
        return  lhs.grind == rhs.grind &&
            lhs.coffeeAmount == rhs.coffeeAmount &&
            lhs.waterAmount == rhs.waterAmount &&
            lhs.steps == rhs.steps &&
            lhs.method == rhs.method &&
            lhs.time == rhs.time
    }
}


// Save UserGuide object to iCloud
extension CKRecord {
    convenience init(userGuide: UserGuide) {
        let recordID = userGuide.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: UserGuideKeys.typeKey, recordID: recordID)
        self.setValue(userGuide.title, forKey: UserGuideKeys.titleKey)
        self.setValue(userGuide.grind, forKey: UserGuideKeys.grindKey)
        self.setValue(userGuide.coffeeAmount, forKey: UserGuideKeys.coffeeAmountKey)
        self.setValue(userGuide.waterAmount, forKey: UserGuideKeys.waterAmountKey)
        self.setValue(userGuide.steps, forKey: UserGuideKeys.stepsKey)
        self.setValue(userGuide.method, forKey: UserGuideKeys.methodKey)
        self.setValue(userGuide.time, forKey: UserGuideKeys.timeKey)
        self.setValue(userGuide.timestamp, forKey: UserGuideKeys.timestampKey)
        userGuide.ckRecordID = recordID
    }
}

// Initializes UserGuide object from iCloud
extension UserGuide {
    convenience init?(record: CKRecord) {
        guard let title = record[UserGuideKeys.titleKey] as? String,
            let grind = record[UserGuideKeys.grindKey] as? String,
            let coffeeAmount = record[UserGuideKeys.coffeeAmountKey] as? Double,
            let waterAmount = record[UserGuideKeys.waterAmountKey] as? Double,
            let steps = record[UserGuideKeys.stepsKey] as? [String],
            let method = record[UserGuideKeys.methodKey] as? String,
            let time = record[UserGuideKeys.timeKey] as? Date,
            let timestamp = record[UserGuideKeys.timestampKey] as? Date else { return nil }
        self.init(title: title, grind: grind, coffeeAmount: coffeeAmount, waterAmount: waterAmount, steps: steps, method: method, time: time, timestamp: timestamp)
        ckRecordID = record.recordID
    }
}
