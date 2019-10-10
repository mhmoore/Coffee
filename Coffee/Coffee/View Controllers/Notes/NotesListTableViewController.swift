//
//  NotesListTableViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/14/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults: [String: [Note]] = [:]
    var isSearching: Bool = false
    
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
        searchBar.delegate = self
        setupUI()
        createToolBar()
        tableView.tableFooterView = UIView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Custom Methods
    func setupUI() {
        title = "Notes"
        view.backgroundColor = .background
        tableView.backgroundColor = .textFieldBackground
        searchBar.backgroundColor = .textFieldBackground
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return methods.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return methods[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isSearching else { return dictionary[methods[section]]?.count ?? 0}
        return searchResults[methods[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        if isSearching {
            guard let notes = searchResults[methods[indexPath.section]] else { return UITableViewCell() }
            let note = notes[indexPath.row]
            cell.textLabel?.text = note.coffeeName
            cell.detailTextLabel?.text = note.roaster
        } else {
            guard let notes = dictionary[methods[indexPath.section]] else { return UITableViewCell() }
            let note = notes[indexPath.row]
            cell.textLabel?.text = note.coffeeName
            cell.detailTextLabel?.text = note.roaster
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if isSearching {
                guard let notes = searchResults[methods[indexPath.section]] else { return }
                let note = notes[indexPath.row]
                for guide in guides {
                    if guide.notes.contains(note) {
                        GuideController.shared.remove(note: note, guide: guide)
                    }
                    if guide.notes.count > 1 {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        tableView.reloadData()
                    }
                }
            } else {
                guard let notes = dictionary[methods[indexPath.section]] else { return }
                let note = notes[indexPath.row]
                for guide in guides {
                    if guide.notes.contains(note) {
                        GuideController.shared.remove(note: note, guide: guide)
                    }
                    if guide.notes.count > 1 {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        tableView.reloadData()
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
                if isSearching {
                    guard let notes = searchResults[methods[indexPath.section]] else { return }
                    let note = notes[indexPath.row]
                    destinationVC.note = note
                } else {
                    guard let notes = dictionary[methods[indexPath.section]] else { return }
                    let note = notes[indexPath.row]
                    destinationVC.note = note
                }
            }
        }
    }
    
    // MARK: - Custom Methods
    func createToolBar() {
         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         toolBar.backgroundColor = .white
         let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
         toolBar.setItems([flexibleSpace, doneButton], animated: true)
         toolBar.isUserInteractionEnabled = true
         searchBar.inputAccessoryView = toolBar
     }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - SearchBar Delegate
extension NotesListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchBar.showsCancelButton = true
        let searchTerm = searchText.lowercased()
        guard !searchTerm.isEmpty else { isSearching = false; return }
        var resultsDictionary = [String: [Note]]()
        for (method, notesArray) in dictionary {
            for note in notesArray {
                if note.coffeeName.lowercased().contains(searchTerm) || note.roaster.lowercased().contains(searchTerm) || note.tastingNotes.lowercased().contains(searchTerm) {
                    resultsDictionary[method, default: []].append(note)
                }
            }
        }
        self.searchResults = resultsDictionary
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}
