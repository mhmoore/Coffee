//
//  NotesListTableViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/14/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    var guides: [Guide] {
        var guides: [Guide] = []
        for guide in GuideController.shared.standardGuides {
            guides.append(guide)
        }
        guard let userGuides = GuideController.shared.userGuides else { return guides }
        for guide in userGuides {
            guides.append(guide)
        }
        return guides
    }
    var methods: [String] {
        var methods: [String] = []
        for guide in guides {
            if !guide.notes.isEmpty && !methods.contains(guide.method) {
                methods.append(guide.method)
            }
        }
        return methods
    }
    
    var dictionary: [String : [Note]] {
        var dictionary: [String : [Note]] = [:]
        var i = 0
        while i < methods.count {
            for guide in guides {
                if !guide.notes.isEmpty && guide.method == methods[i] {
                    var notes = guide.notes
                    notes += dictionary[guide.method] ?? []
                    dictionary[guide.method] = notes
                }
            }
            i += 1
        }
        return dictionary
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return methods.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return methods[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary[methods[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        guard let notes = dictionary[methods[indexPath.section]] else { return UITableViewCell() }
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.coffeeName
        cell.detailTextLabel?.text = note.roaster
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let notes = dictionary[methods[indexPath.section]] else { return }
            let note = notes[indexPath.row]
            for guide in guides {
                if guide.notes.contains(note) {
                    GuideController.shared.remove(note: note, guide: guide)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNoteDetailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? NoteDetailViewController,
                    let notes = dictionary[methods[indexPath.section]] else { return }
                let note = notes[indexPath.row]
                destinationVC.note = note
            }
        }
    }
}
