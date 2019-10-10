//
//  NoteDetailViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/14/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var roasterTextLabel: UILabel!
    @IBOutlet weak var coffeeNameTextLabel: UILabel!
    @IBOutlet weak var originTextLabel: UILabel!
    @IBOutlet weak var grindTextLabel: UILabel!
    @IBOutlet weak var methodTextLabel: UILabel!
    @IBOutlet weak var notesTextLabel: UILabel!
    
    // MARK: - Properties
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
        roasterTextLabel.text = note.roaster
        coffeeNameTextLabel.text = note.coffeeName
        originTextLabel.text = note.origin
        grindTextLabel.text = note.grind
        methodTextLabel.text = note.method
        notesTextLabel.text = note.tastingNotes
        title = note.coffeeName
        view.backgroundColor = .background
    }
}
