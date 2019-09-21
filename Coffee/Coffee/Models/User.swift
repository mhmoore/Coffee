//
//  User.swift
//  Coffee
//
//  Created by Michael Moore on 9/12/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

//struct UserKeys {
//
//    static let nameKey = "Name"
//    static let emailKey = "Email"
//    static let passwordKey = "Password"
//    static let appleUserReferenceKey = "AppleUserReference"
//    static let typeKey = "User"
//}

class User {
    
    let name: String
    let email: String
    var password: String
//    var ckRecordID: CKRecord.ID
//    var appleUserReference: CKRecord.Reference
    
    init(name: String, email: String, password: String) { // ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserReference: CKRecord.Reference)
        self.name = name
        self.email = email
        self.password = password
//        self.ckRecordID = ckRecordID
//        self.appleUserReference = appleUserReference
    }
}

//// Save User object to iCloud
//extension CKRecord {
//    convenience init(user: User) {
//        self.init(recordType: UserKeys.typeKey, recordID: user.ckRecordID)
//        setValue(user.name, forKey: UserKeys.nameKey)
//        setValue(user.email, forKey: UserKeys.emailKey)
//        setValue(user.password, forKey: UserKeys.passwordKey)
//        setValue(user.appleUserReference, forKey: UserKeys.appleUserReferenceKey)
//    }
//}
//
//// Initializes User object from iCloud
//extension User {
//    convenience init?(record: CKRecord) {
//        guard let name = record[UserKeys.nameKey] as? String,
//            let email = record[UserKeys.emailKey] as? String,
//            let password = record[UserKeys.passwordKey] as? String,
//            let appleUserReference = record[UserKeys.appleUserReferenceKey] as? CKRecord.Reference else { return nil }
//        self.init(name: name, email: email, password: password, appleUserReference: appleUserReference)
//        ckRecordID = record.recordID
//    }
//}
