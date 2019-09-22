//
//  UserNoteController.swift
//  Coffee
//
//  Created by Michael Moore on 9/13/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

class UserNoteController {
    
    static let shared = UserNoteController()
    var notes: [UserNote] = []
//    let privateDB = CKContainer.default().privateCloudDatabase
    
    func createNote(roaster: String, coffeeName: String, origin: String, grind: String, ratio: String, tastingNotes: String, method: String) {
        let note = UserNote(roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, ratio: ratio, method: method, tastingNotes: tastingNotes)
        notes.insert(note, at: 0)
//        save(note: note) { (success) in
//            if success {
//                print("The created note was saved")
//            }
//        }
    }
    
//    func save(note: UserNote, completion: @escaping (Bool) -> Void) {
//        let noteRecord = CKRecord(userNote: note)
//        privateDB.save(noteRecord) { (_, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//            completion(true)
//        }
//    }
    
//    func fetchNotes(completion: @escaping (Bool) -> Void) {
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: UserNoteKeys.typeKey, predicate: predicate)
//
//        privateDB.perform(query, inZoneWith: nil) { (records, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//
//            guard let records = records else { completion(false); return }
//            let notes = records.compactMap( {UserNote(record: $0)} )
//            self.notes = notes
//            completion(true)
//        }
//    }
    
    func update(note: UserNote, with roaster: String, coffeeName: String, origin: String, grind: String, ratio: String, tastingNotes: String, method: String) { // TODO: Add completion when finishing CK
        note.roaster = roaster
        note.coffeeName = coffeeName
        note.origin = origin
        note.grind = grind
        note.ratio = ratio
        note.tastingNotes = tastingNotes
        note.method = method
        note.timestamp = Date()
        
//        let modificationOp = CKModifyRecordsOperation(recordsToSave: [CKRecord(userNote: note)], recordIDsToDelete: nil)
//        modificationOp.savePolicy = .changedKeys
//        modificationOp.queuePriority = .normal
//        modificationOp.qualityOfService = .userInteractive
//        modificationOp.modifyRecordsCompletionBlock = { (_, _, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//            completion(true)
//        }
//        privateDB.add(modificationOp)
    }
    
    func delete(note: UserNote) {
//        guard let noteRecord = note.ckRecordID,
            guard let firstIndex = self.notes.firstIndex(of: note) else { return }
        notes.remove(at: firstIndex)
//        privateDB.delete(withRecordID: noteRecord) { (_, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                completion(false)
//                return
//            }
//            completion(true)
//        }
    }
}
