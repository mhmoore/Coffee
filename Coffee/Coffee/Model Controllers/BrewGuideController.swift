//
//  BrewGuideController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import CloudKit
import UIKit.UIImage

class BrewGuideController {
    
    static let shared = BrewGuideController()
    var guides: [BrewGuide] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func saveGuide(userGuide: Bool, title: String, grind: String, coffeeAmount: Double, waterAmount: Double, prep: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage, time: TimeInterval, completion: @escaping (Bool) -> Void) {
        
        let guide = BrewGuide(userGuide: userGuide, title: title, grind: grind, coffeeAmount: coffeeAmount, waterAmount: waterAmount, prep: prep, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage, time: time)
        let guideRecord = CKRecord(brewGuide: guide)
        guides.insert(guide, at: 0)
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
        let query = CKQuery(recordType: BrewGuideKeys.typeKey, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            let guides = records.compactMap( {BrewGuide(record: $0)} )
            self.guides = guides
            completion(true)
            }
    }
    
    
    func update(guide: BrewGuide, with userGuide: Bool, title: String, grind: String, coffeeAmount: Double, waterAmount: Double, prep: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage, time: TimeInterval, completion: @escaping (Bool) -> Void) {
        guide.userGuide = userGuide
        guide.title = title
        guide.grind = grind
        guide.coffeeAmount = coffeeAmount
        guide.waterAmount = waterAmount
        guide.prep = prep
        guide.steps = steps
        guide.method = method
        guide.methodInfo = methodInfo
        guide.methodImage = methodImage
        guide.time = time
        guide.timestamp = Date()
        
        let modificationOP = CKModifyRecordsOperation(recordsToSave: [CKRecord(brewGuide: guide)], recordIDsToDelete: nil)
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
    
    func remove(guide: BrewGuide, completion: @escaping (Bool) -> Void) {
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
