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
        loadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserNoteController.shared.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = UserNoteController.shared.notes[indexPath.row]
        cell.textLabel?.text = note.coffeeName
        cell.detailTextLabel?.text = note.method

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = UserNoteController.shared.notes[indexPath.row]
            UserNoteController.shared.delete(note: note) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNoteDetailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? NoteDetailViewController else { return }
                let note = UserNoteController.shared.notes[indexPath.row]
                destinationVC.note = note
            }
        }
    }
    
    // MARK: - Custom Methods
    func loadData() {
        UserNoteController.shared.fetchNotes { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}
