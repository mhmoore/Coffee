//
//  BrewGuideController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class GuideController {
    
    static let shared = GuideController()
    
    // MARK: - Properties
    var userGuides: [Guide]?
    var standardGuides: [Guide] = []
    
    init() {
        let userGuide = false
        let title = "CHEMEX"
        let coffee = 26.7
        let grind = "Medium-Coarse"
        let prep = "Do this stuff"
        let steps = [Step(title: "Pour", water: 150.0, time: 10.0, text: "Pour 150g of water over 10.0 seconds"), Step(title: "Wait", water: 0.0, time: 10.0, text: "Wait for 10.0 seconds and let it bloom"), Step(title: "Pour", water: 300.0, time: 240.0, text: "Pour 300.0 of water over 240.0 seconds")]
        let method = "CHEMEX"
        let methodInfo = "Clean, crisp cup of coffee"
        
        
        createGuide(userGuide: userGuide, title: title, coffee: coffee, grind: grind, prep: prep, steps: steps, method: method, methodInfo: methodInfo)
        
        let aeroUserGuide = false
        let aeroTitle = "AeroPress"
        let aeroCoffee = 17.0
        let aeroGrind = "Medium"
        let aeroPrep = "Do this stuff"
        let aeroSteps = [Step(title: "Pour", water: 150.0, time: 10.0, text: "Pour 150g of water over 10.0 seconds"), Step(title: "Wait", water: 0.0, time: 10.0, text: "Wait for 10.0 seconds and let it bloom"), Step(title: "Pour", water: 300.0, time: 240.0, text: "Pour 300.0 of water over 240.0 seconds"), Step(title: "Other", water: 0.0, time: 45.0, text: "Press down plunger for 45 seconds")]
        let aeroMethod = "AeroPress"
        let aeroMethodInfo = "A darn good cup of coffee"
        
        
        createGuide(userGuide: aeroUserGuide, title: aeroTitle, coffee: aeroCoffee, grind: aeroGrind, prep: aeroPrep, steps: aeroSteps, method: aeroMethod, methodInfo: aeroMethodInfo)
    }
    
    // MARK: - Guide CRUD
    func createGuide(userGuide: Bool, title: String, coffee: Double, grind: String, prep: String, steps: [Step], method: String, methodInfo: String) {
        let guide = Guide(userGuide: userGuide, title: title, method: method, methodInfo: methodInfo, coffee: coffee, grind: grind, prep: prep, steps: steps)
        let note = Note(roaster: "SweetBloom", coffeeName: "Yummm", origin: "Latin America", grind: grind, ratio: "1 : 6", method: method, tastingNotes: methodInfo)
        let note2 = Note(roaster: "BoxCar", coffeeName: "Derailer", origin: "Ethiopia", grind: grind, ratio: "1 : 17", method: method, tastingNotes: methodInfo)
        guide.notes.append(note)
        guide.notes.append(note2)
//        userGuides?.insert(guide, at: 0)
        standardGuides.insert(guide, at: 0)
    }
    
    func update(guide: Guide, userGuide: Bool, title: String, coffee: Double, grind: String, steps: [Step], notes: [Note] ) {
        guide.userGuide = userGuide
        guide.title = title
        guide.steps = steps
        guide.notes = notes
        
        saveToPersistentStorage()
    }
    
    func remove(guide: Guide) {
        if guide.userGuide != true {
            guard let firstIndex = standardGuides.firstIndex(of: guide) else { return }
            standardGuides.remove(at: firstIndex)
        } else {
            guard let firstIndex = userGuides?.firstIndex(of: guide) else { return }
            userGuides?.remove(at: firstIndex)
        }
        
        saveToPersistentStorage()
    }
    
    // MARK: - Note CRUD
    func add(note: Note, guide: Guide) {
        guide.notes.append(note)
        
        saveToPersistentStorage()
    }
    
    func remove(note: Note, guide: Guide) {
        guard let index = guide.notes.firstIndex(of: note) else {return}
        guide.notes.remove(at: index)
        
        saveToPersistentStorage()
    }
    
    // MARK: - Step CRUD
    func add(step: Step, guide: Guide) {
        guide.steps.append(step)
    }
    
    func remove(step: Step, from guide: Guide) {
        guard let index = guide.steps.firstIndex(of: step) else { return }
        guide.steps.remove(at: index)
    }

    
    // MARK: - Persistence
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "Coffee.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        let guides = [standardGuides, userGuides]
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(guides)
            try data.write(to: fileURL())
        } catch let encodingError {
            print("There was an error saving! \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistentStorage() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedGuides = try jsonDecoder.decode([[Guide]?].self, from: data)
            guard let standardGuides = decodedGuides[0] else { return }
            self.standardGuides = standardGuides
            if let userGuides = decodedGuides[1] {
                self.userGuides = userGuides
            }
        } catch let decodingError {
            print("There was an error decoding! \(decodingError.localizedDescription)")
        }
    }
}
