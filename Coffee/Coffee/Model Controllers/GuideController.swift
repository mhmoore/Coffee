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
    
    func standards() {
        
        // Chemex
        let chemexUserGuide = false
        let chemexTitle = "CHEMEX"
        let chemexGrind = "Medium - Coarse"
        let chemexCoffee = 42
        let chemexSteps = [Step(duration: 10, amount: 150, type: .pour), Step(duration: 10, amount: nil, type: .stir), Step(duration: 25, amount: nil, type: .wait), Step(duration: 20, amount: 300, type: .pour), Step(duration: 40, amount: nil, type: .wait), Step(duration: 15, amount: 250, type: .pour), Step(duration: 120, amount: nil, type: .wait)]
        var chemexTotalWater: Double {
            var total: Double = 0
            for step in chemexSteps {
                if let amountOfWater = step.amountOfWater {
                    total += amountOfWater
                }
            }
            return total
        }
        let chemexPrep = """
            Things you'll need:
                8-cup Chemex
                Chemex filter
                42g of ground coffee
                About 800g of almost boiling water (~205F)
                Scale
                Stir stick
                Your favorite mug

                - Place the filter with the single fold away from the spout
                - Pour no more than 100g of water over the filter creating a nice even seal
                    (this preheats our brewer, and gets rid of the paper taste)
                - Holding the filter in place, discard the water
                - Place coffee in the center of the filter, and zero out your scale
                - You are ready to start brewing!
            """
        let chemexMethod = "CHEMEX"
        let chemexMethodInfo = "The CHEMEX was invented in 1941 by Dr. Peter Schlumbohm, a chemist, who was inspired by lab equipment for it's design.  In 1943, it was even displayed in The Museum of Modern Art as one of the best-designed products."
        let chemexMethodImage: UIImage
        var chemexTotalTime: TimeInterval {
            var total: TimeInterval = 0.0
            for step in chemexSteps {
                total += step.duration
            }
            return total
        }
        // AeroPress
        let aeroUserGuide = false
        let aeroTitle = "AeroPress"
        let aeroGrind = "Medium - Coarse"
        let aeroCoffee = 42
        let aeroSteps = [Step(duration: 10, amount: 150, type: .pour), Step(duration: 10, amount: nil, type: .stir), Step(duration: 25, amount: nil, type: .wait), Step(duration: 20, amount: 300, type: .pour), Step(duration: 40, amount: nil, type: .wait), Step(duration: 15, amount: 250, type: .pour), Step(duration: 120, amount: nil, type: .wait)]
        var aeroTotalWater: Double {
            var total: Double = 0
            for step in aeroSteps {
                if let amountOfWater = step.amountOfWater {
                    total += amountOfWater
                }
            }
            return total
        }
        let aeroPrep = """
            Things you'll need:
                AeroPress Brewer
                AeroPress filter
                17g of ground coffee
                Almost boiling water (~205F)
                Scale
                AeroPress paddle or stir stick
                Your favorite mug

                - Place the filter in the basket, and affix the basket to the bottom of the brew chamber
                - Place the AeroPress on top of your mug
                - Pour some hot water in the brew chamber, over the filter, and into your cup
                    (this preheats our brewer, our mug, and gets rid of the paper taste)
                - Discard the water from your mug, and place brewer back onto your mug
                - Place coffee in the brew chamber
                - You are ready to start brewing!
            """
        let aeroMethod = "AeroPress"
        let aeroMethodInfo = "The CHEMEX was invented in 1941 by Dr. Peter Schlumbohm, a chemist, who was inspired by lab equipment for it's design.  In 1943, it was even displayed in The Museum of Modern Art as one of the best-designed products."
        let aeroMethodImage: UIImage
        var aeroTotalTime: TimeInterval {
            var total: TimeInterval = 0.0
            for step in aeroSteps {
                total += step.duration
            }
            return total
        }
        // Moka Pot
        // Kalita
        // Hario V60
        // Stagg
        // French Press
        
        
        
    }
    
}
