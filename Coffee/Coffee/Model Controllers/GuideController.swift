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

class GuideController {
    // MARK: - Properties
    static let shared = GuideController()
    var guides: [Guide] = []
    var userGuides: [Guide] = []
    var standardGuides: [Guide] = []
    var separatedGuides: [[Guide]] {
        get {
            return separate(guides: guides)
        }
    }
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Mock Data
//    init() {
//
//        let userGuide1 = true
//        let title1 = "My Chemex"
//        let grind1 = "medium"
//        let coffee1 = 26.7
//        let prep1 = "asdgrgth"
//        let steps1 = StepController.shared.steps
//        let method1 = "Chemex"
//        let methodInfo1 = "dfadfas"
//        let methodImage1 = UIImage(named: "chemex")!
//
//        createGuide(userGuide: userGuide1, title: title1, grind: grind1, coffee: coffee1, prep: prep1, steps: steps1, method: method1, methodInfo: methodInfo1, methodImage: methodImage1)
//
//        let userGuide = false
//        let title = "Chemex"
//        let grind = "medium"
//        let coffee = 26.7
//        let prep = "asdgrgth"
//        let steps = StepController.shared.steps
//        let method = "Chemex"
//        let methodInfo = "dfadfas"
//        let methodImage = UIImage(named: "chemex")!
//
//        createGuide(userGuide: userGuide, title: title, grind: grind, coffee: coffee, prep: prep, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage)
//    }
    
    // MARK: - CRUD
    func createGuide(userGuide: Bool = true, title: String, grind: String, coffee: Double, prep: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage) {
        let guide = Guide(userGuide: userGuide, title: title, grind: grind, coffee: coffee, prep: prep, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage)
        guides.insert(guide, at: 0)
        saveGuide(guide: guide) { (success) in
            if success {
                print("The created guide was saved")
            }
        }
    }
    
    func saveGuide(guide: Guide, completion: @escaping (Bool) -> Void) {
        let guideRecord = CKRecord(brewGuide: guide)
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
        let query = CKQuery(recordType: GuideKeys.typeKey, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            let guides = records.compactMap( {Guide(record: $0)} )
            self.guides = guides
            completion(true)
            }
    }
    
    func update(guide: Guide, with userGuide: Bool, title: String, grind: String, coffee: Double, prep: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage, completion: @escaping (Bool) -> Void) {
        guide.userGuide = userGuide
        guide.title = title
        guide.grind = grind
        guide.coffee = coffee
        guide.prep = prep
        guide.steps = steps
        guide.method = method
        guide.methodInfo = methodInfo
        guide.methodImage = methodImage
        
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
    
    func remove(guide: Guide, completion: @escaping (Bool) -> Void) {
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
    func separate(guides: [Guide]) -> [[Guide]] {
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
