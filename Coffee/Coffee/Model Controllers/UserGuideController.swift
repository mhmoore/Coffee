//
//  UserGuideController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import CloudKit

class UserGuideController {
    
    static let shared = UserGuideController()
    var guides: [UserGuide] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func saveGuide(title: String, grind: String, coffeeAmount: Double, waterAmount: Double, steps: [String], method: String, time: Date, completion: @escaping (Bool) -> Void) {
        
        let guide = UserGuide(title: title, grind: grind, coffeeAmount: coffeeAmount, waterAmount: waterAmount, steps: steps, method: method, time: time)
        let guideRecord = CKRecord(userGuide: guide)
        self.guides.insert(guide, at: 0)
        privateDB.save(guideRecord) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func fetchGuides(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: UserGuideKeys.typeKey, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            let guides = records.compactMap( {UserGuide(record: $0)} )
            self.guides = guides
            completion(true)
        }
    }
    
    func update(guide: UserGuide, with title: String, grind: String, coffeeAmount: Double, waterAmount: Double, steps: [String], method: String, time: Date, completion: @escaping (Bool) -> Void) {
        guide.title = title
        guide.grind = grind
        guide.coffeeAmount = coffeeAmount
        guide.waterAmount = waterAmount
        guide.steps = steps
        guide.method = method
        guide.time = time
        guide.timestamp = Date()
        
        let modificationOP = CKModifyRecordsOperation(recordsToSave: [CKRecord(userGuide: guide)], recordIDsToDelete: nil)
        modificationOP.savePolicy = .changedKeys
        modificationOP.queuePriority = .normal
        modificationOP.qualityOfService = .userInteractive
        modificationOP.modifyRecordsCompletionBlock = { (_, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            completion(true)
        }
        privateDB.add(modificationOP)
    }
    
    func remove(guide: UserGuide, completion: @escaping (Bool) -> Void) {
        guard let guideRecord = guide.ckRecordID,
            let firstIndex = self.guides.firstIndex(of: guide) else { return }
        guides.remove(at: firstIndex)
        privateDB.delete(withRecordID: guideRecord) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}
