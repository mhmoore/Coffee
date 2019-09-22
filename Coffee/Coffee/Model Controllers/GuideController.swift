//
//  BrewGuideController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import UIKit.UIImage

class GuideController {
    // MARK: - Properties
    static let shared = GuideController()
    var guides: [Guide] = []
    var userGuides: [Guide]?
    var standardGuides: [Guide] = []
    var separatedGuides: [[Guide]?] {
        get {
            return separate(guides: guides)
        }
    }
//    let privateDB = CKContainer.default().privateCloudDatabase
    
    init() {
        
        let userGuide = false
        let title = "CHEMEX"
        let grind = "Medium - Coarse"
        let grindImage = UIImage(named: "chemex")
        let coffee = 26.7
        let ratio = "6:1"
        let steps = StepController.shared.steps
        let method = "CHEMEX"
        let methodInfo = "dsfjaf"
        let methodImage = UIImage(named: "chemex")
        
        createGuide(userGuide: userGuide, title: title, grind: grind, grindImage: grindImage!, coffee: coffee, ratio: ratio, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage!)
        
//        let userGuide1 = true
//        let title1 = "CHEMEX"
//        let grind1 = "Medium - Coarse"
//        let grindImage1 = UIImage(named: "chemex")
//        let coffee1 = 26.7
//        let waters1 = [23.2]
//        let times1 = [23.8]
//        let yields1 = "20"
//        let ratio1 = "6:1"
//        let steps1 = StepController.shared.steps
//        let method1 = "CHEMEX"
//        let methodInfo1 = "dsfjaf"
//        let methodImage1 = UIImage(named: "chemex")
//
//        createGuide(userGuide: userGuide1, title: title1, grind: grind1, grindImage: grindImage1!, coffee: coffee1, waters: waters1, times: times1, yields: yields1, ratio: ratio1, steps: steps1, method: method1, methodInfo: methodInfo1, methodImage: methodImage1!)
    }
    
    
    
    // MARK: - CRUD
    func createGuide(userGuide: Bool, title: String, grind: String, grindImage: UIImage, coffee: Double, ratio: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage) {
        let guide = Guide(userGuide: userGuide, title: title, grind: grind, grindImage: grindImage, coffee: coffee, ratio: ratio, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage)
        userGuides?.insert(guide, at: 0)
        guides.append(guide) // TODO: Comment out after uploading guides
//        saveGuide(guide: guide) { (success) in
//            if success {
//                print("The created guide was saved")
//            }
//        }
    }
    
//    func saveGuide(guide: Guide, completion: @escaping (Bool) -> Void) {
//        let guideRecord = CKRecord(brewGuide: guide)
//        privateDB.save(guideRecord) { (_, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//            completion(true)
//        }
//    }
    
//    func fetchGuides(completion: @escaping (Bool) -> Void) {
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: GuideKeys.typeKey, predicate: predicate)
//        privateDB.perform(query, inZoneWith: nil) { (records, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//
//            guard let records = records else { completion(false); return }
//            let guides = records.compactMap( {Guide(record: $0)} )
//            self.guides = guides
//            completion(true)
//            }
//    }
    
    func update(guide: Guide, with userGuide: Bool, title: String, grind: String, grindImage: UIImage, coffee: Double, ratio: String, steps: [Step], method: String, methodInfo: String, methodImage: UIImage) { // TODO: Add completion when finishing CK
        guide.userGuide = userGuide
        guide.title = title
        guide.grind = grind
        guide.grindImage = grindImage
        guide.coffee = coffee
        guide.ratio = ratio
        guide.steps = steps
        guide.method = method
        guide.methodInfo = methodInfo
        guide.methodImage = methodImage
        
//        let modificationOP = CKModifyRecordsOperation(recordsToSave: [CKRecord(brewGuide: guide)], recordIDsToDelete: nil)
//        modificationOP.savePolicy = .changedKeys
//        modificationOP.queuePriority = .normal
//        modificationOP.qualityOfService = .userInteractive
//        modificationOP.modifyRecordsCompletionBlock = { (_, _, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//            completion(true)
//        }
//        privateDB.add(modificationOP)
    }
    
    func remove(guide: Guide) {
        guard let firstIndex = self.guides.firstIndex(of: guide) else { return }
        guides.remove(at: firstIndex)
    }
//    func remove(guide: Guide, completion: @escaping (Bool) -> Void) {
//        guard let guideRecord = guide.ckRecordID,
//            let firstIndex = self.guides.firstIndex(of: guide) else { return }
//        guides.remove(at: firstIndex)
//        privateDB.delete(withRecordID: guideRecord) { (_, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//            completion(true)
//        }
//    }
    
    // MARK: - Custom Methods
    func separate(guides: [Guide]) -> [[Guide]?] {
        for guide in guides {
            if guide.userGuide == true {
                if var userGuides = userGuides {
                    userGuides.append(guide)
                }
            } else {
                standardGuides.append(guide)
            }
        }
        let separatedGuides = [userGuides, standardGuides]
        return separatedGuides
    }
}
