//
//  NoteController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class NoteController {
    
    static func createNote(guide: Guide, roaster: String, coffeeName: String, origin: String, grind: String, ratio: String, tastingNotes: String, method: String) {
        let note = Note(roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, ratio: ratio, method: method, tastingNotes: tastingNotes)
        GuideController.shared.add(note: note, to: guide)
    }
    
//    func update(note: Note, with roaster: String, coffeeName: String, origin: String, grind: String, ratio: String, tastingNotes: String, method: String) {
//        note.roaster = roaster
//        note.coffeeName = coffeeName
//        note.origin = origin
//        note.grind = grind
//        note.ratio = ratio
//        note.tastingNotes = tastingNotes
//        note.method = method
//    }
//
//    func delete(note: Note) {
//        guard let firstIndex = self.notes.firstIndex(of: note) else { return }
//        notes.remove(at: firstIndex)
//    }
}
