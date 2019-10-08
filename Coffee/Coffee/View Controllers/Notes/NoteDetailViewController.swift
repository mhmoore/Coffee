//
//  NoteDetailViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/14/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var roasterTextLabel: UILabel!
    @IBOutlet weak var coffeeNameTextLabel: UILabel!
    @IBOutlet weak var originTextLabel: UILabel!
    @IBOutlet weak var grindTextLabel: UILabel!
    @IBOutlet weak var methodTextLabel: UILabel!
    @IBOutlet weak var notesTextLabel: UILabel!
    
    var note: Note? {
        didSet {
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Custom Methods
    func updateViews() {
        guard let note = note else { return }
        roasterTextLabel.text = "Roaster: \(note.roaster)"
        coffeeNameTextLabel.text = "Coffee Name: \(note.coffeeName)"
        originTextLabel.text = "Origin: \(note.origin)"
        grindTextLabel.text = "Grind: \(note.grind)"
        methodTextLabel.text = "Method: \(note.method)"
        notesTextLabel.text = "Notes: \(note.tastingNotes)"
        title = note.coffeeName
        view.backgroundColor = .background
    }
}
