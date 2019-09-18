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
    // MARK: - Properties
    static let shared = BrewGuideController()
    var guides: [BrewGuide] = []
    var userGuides: [BrewGuide] = []
    var standardGuides: [BrewGuide] = []
    var separatedGuides: [[BrewGuide]] {
        get {
            return separate(guides: guides)
        }
    }
    let privateDB = CKContainer.default().privateCloudDatabase

    // MARK: - Mock Data
    init() {

        let userGuide1 = true
        let title1 = "My Chemex"
        let grind1 = "medium"
        let coffeeAmount1 = 26.7
        let waterAmount1 = 120.8
        let prep1 = "asdgrgth"
        let steps1 = StepController.shared.steps
        let method1 = "Chemex"
        let methodInfo1 = "dfadfas"
        let methodImage1 = UIImage(named: "chemex")!
        let time1 = 290

        let myChemex = BrewGuide(userGuide: userGuide1, title: title1, grind: grind1, coffeeAmount: coffeeAmount1, waterAmount: waterAmount1, prep: prep1, steps: steps1, method: method1, methodInfo: methodInfo1, methodImage: methodImage1, time: TimeInterval(time1))

        let userGuide = false
        let title = "Chemex"
        let grind = "medium"
        let coffeeAmount = 26.7
        let waterAmount = 320.2
        let prep = "asdgrgth"
        let steps = StepController.shared.steps
        let method = "Chemex"
        let methodInfo = "dfadfas"
        let methodImage = UIImage(named: "chemex")!
        let time = 300

        let chemex = BrewGuide(userGuide: userGuide, title: title, grind: grind, coffeeAmount: coffeeAmount, waterAmount: waterAmount, prep: prep, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage, time: TimeInterval(time))

        guides = [chemex, myChemex]
    }
    
    
    // MARK: - CRUD
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
    
    // MARK: - Custom Methods
    func separate(guides: [BrewGuide]) -> [[BrewGuide]] {
        for guide in guides {
            if guide.userGuide == true {
                userGuides.append(guide)
            } else {
                standardGuides.append(guide)
            }
        }
        let separatedGuides = [userGuides, standardGuides]
        return separatedGuides
    }
}
