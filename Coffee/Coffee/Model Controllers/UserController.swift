//
//  UserController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    static let shared = UserController()
    var currentUser: User?
    let privateDB = CKContainer.default().privateCloudDatabase
    
//    init() {
//        let name = "Mike"
//        let email = "coffee1234@gmail.com"
//        let password = "mvdoaje35"
//
//        createUser(name: name, email: email, password: password) { (success) in
//            if success {
//                print("user was created")
//            }
//        }
//    }
    
    func createUser(name: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            guard let recordID = recordID else { completion(false); return }
            let reference = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
            let newUser = User(name: name, email: email, password: password, appleUserReference: reference)
            let userRecord = CKRecord(user: newUser)
            
            self.privateDB.save(userRecord, completionHandler: { (record, error) in
                if let error = error {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    completion(false)
                    return
                }
                
                if let record = record {
                    let savedUser = User(record: record)
                    self.currentUser = savedUser
                    completion(true)
                }
            })
        }
    }
    
    func fetchUser(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: UserKeys.typeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            
            if let record = records?.first {
                let foundUser = User(record: record)
                self.currentUser = foundUser
                completion(true)
            }
        }
    }
    
    func deleteUser(user: User, completion: @escaping (Bool) -> Void) {
        
        privateDB.delete(withRecordID: user.ckRecordID) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}
