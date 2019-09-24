//
//  NotesListTableViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/14/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
    }

    // MARK: - Table view data source
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return GuideController.
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
//        let note = NoteController.shared.notes[indexPath.row]
//        cell.textLabel?.text = note.coffeeName
//        cell.detailTextLabel?.text = note.roaster
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let note = NoteController.shared.notes[indexPath.row]
//            NoteController.shared.delete(note: note)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//    
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toNoteDetailVC" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                guard let destinationVC = segue.destination as? NoteDetailViewController else { return }
//                let note = NoteController.shared.notes[indexPath.row]
//                destinationVC.note = note
//            }
//        }
//    }
}
