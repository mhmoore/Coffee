//
//  BrewGuideController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

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
    
    init() {
        let userGuide = false
        let title = "CHEMEX"
        let coffee = 26.7
        let grind = "Medium-Coarse"
        let prep = "Do this stuff"
        let steps = [Step(title: "Pour", water: 150.0, time: 10.0, text: "Pour 150g of water over 10.0 seconds"), Step(title: "Wait", water: 0.0, time: 10.0, text: "Wait for 10.0 seconds and let it bloom")]
        let method = "CHEMEX"
        let methodInfo = "Clean, crisp cup of coffee"
        
        createGuide(userGuide: userGuide, title: title, coffee: coffee, grind: grind, prep: prep, steps: steps, method: method, methodInfo: methodInfo)
    }
    
    // MARK: - Guide CRUD
    func createGuide(userGuide: Bool, title: String, coffee: Double, grind: String, prep: String, steps: [Step], method: String, methodInfo: String) {
        let guide = Guide(userGuide: userGuide, title: title, method: method, methodInfo: methodInfo, coffee: coffee, grind: grind, prep: prep, steps: steps)
        userGuides?.insert(guide, at: 0)
        guides.insert(guide, at: 0)
    }
    
    func update(guide: Guide, with userGuide: Bool, title: String, coffee: Double, grind: String, steps: [Step], notes: [Note] ) {
        guide.userGuide = userGuide
        guide.title = title
        guide.steps = steps
        guide.notes = notes
    }
    
    func remove(guide: Guide) {
        guard let firstIndex = self.guides.firstIndex(of: guide) else { return }
        guides.remove(at: firstIndex)
    }
    
    // MARK: - Note CRUD
    func add(note: Note, to guide: Guide) {
        guide.notes.append(note)
    }
    
    func remove(note: Note, from guide: Guide) {
        guard let index = guide.notes.firstIndex(of: note) else {return}
        guide.notes.remove(at: index)
    }
    
    // MARK: - Step CRUD
    func update(step: Int, to guide: Guide, water: Double?, time: TimeInterval?, text: String?) {
        guard let water = water,
            let time = time,
            let text = text else { return }
        
        guide.steps[step].water = water
        guide.steps[step].time = time
        guide.steps[step].text = text
    }
    
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
    
    // MARK: - Persistence
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "Coffee.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
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
            let decodedGuides = try jsonDecoder.decode([Guide].self, from: data)
            guides = decodedGuides
        } catch let decodingError {
            print("There was an error decoding! \(decodingError.localizedDescription)")
        }
    }
}
