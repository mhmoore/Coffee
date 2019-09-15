//
//  UserNote.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import CloudKit

struct UserNoteKeys {
    
    static let typeKey = "UserNote"
    static let timestampKey = "Timestamp"
    static let roasterKey = "Roaster"
    static let coffeeNameKey = "CoffeeName"
    static let originKey = "Origin"
    static let grindKey = "Grind"
    static let methodKey = "Method"
    static let tastingNotesKey = "TastingNotes"
}

class UserNote {
    internal init(roaster: String, coffeeName: String, origin: String, grind: String, method: String, tastingNotes: String, timestamp: Date, ckRecordID: CKRecord.ID?) {
        self.roaster = roaster
        self.coffeeName = coffeeName
        self.origin = origin
        self.grind = grind
        self.method = method
        self.tastingNotes = tastingNotes
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    
    var roaster: String
    var coffeeName: String
    var origin: String
    var grind: String
    var method: String
    var tastingNotes: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID?
    
    init(roaster: String, coffeeName: String, origin: String, grind: String, method: String, tastingNotes: String, timestamp: Date = Date()) {
        self.roaster = roaster
        self.coffeeName = coffeeName
        self.origin = origin
        self.grind = grind
        self.method = method
        self.tastingNotes = tastingNotes
        self.timestamp = timestamp
    }
}

extension UserNote: Equatable {
    static func == (lhs: UserNote, rhs: UserNote) -> Bool {
        return  lhs.roaster == rhs.roaster &&
            lhs.coffeeName == rhs.coffeeName &&
            lhs.method == rhs.method &&
            lhs.origin == rhs.origin &&
            lhs.tastingNotes == rhs.tastingNotes &&
            lhs.grind == rhs.grind
    }
}

// Save UserNote object to iCloud
extension CKRecord {
    convenience init(userNote: UserNote) {
        let recordID = userNote.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: UserNoteKeys.typeKey, recordID: recordID)
        self.setValue(userNote.roaster, forKey: UserNoteKeys.roasterKey)
        self.setValue(userNote.coffeeName, forKey: UserNoteKeys.coffeeNameKey)
        self.setValue(userNote.origin, forKey: UserNoteKeys.originKey)
        self.setValue(userNote.grind, forKey: UserNoteKeys.grindKey)
        self.setValue(userNote.method, forKey: UserNoteKeys.methodKey)
        self.setValue(userNote.tastingNotes, forKey: UserNoteKeys.tastingNotesKey)
        self.setValue(userNote.timestamp, forKey: UserNoteKeys.timestampKey)
        userNote.ckRecordID = recordID
    }
}

// Initializes UserNote object from iCloud
extension UserNote {
    convenience init?(record: CKRecord) {
        guard let roaster = record[UserNoteKeys.roasterKey] as? String,
            let coffeeName = record[UserNoteKeys.coffeeNameKey] as? String,
            let origin = record[UserNoteKeys.originKey] as? String,
            let grind = record[UserNoteKeys.grindKey] as? String,
            let method = record[UserNoteKeys.methodKey] as? String,
            let tastingNotes = record[UserNoteKeys.tastingNotesKey] as? String,
            let timestamp = record[UserNoteKeys.timestampKey] as? Date else { return nil }
        
        self.init(roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, method: method, tastingNotes: tastingNotes, timestamp: timestamp)
        ckRecordID = record.recordID
    }
}
