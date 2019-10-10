//
//  BrewGuideController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class GuideController {
    // MARK: - Shared Instance
    static let shared = GuideController()
    
    // MARK: - Properties
    var userGuides: [Guide]?
    var standardGuides: [Guide] = []
    
    // MARK: - Guide CRUD
    func remove(guide: Guide) {
        if !guide.userGuide {
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
