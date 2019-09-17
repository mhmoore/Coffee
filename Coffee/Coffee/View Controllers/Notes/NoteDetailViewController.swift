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
    
    var note: UserNote? {
        didSet {
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = note?.coffeeName
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
        // TODO: segue to edit notesViewController
    }
    
    // MARK: - Custom Methods
    func updateViews() {
        roasterTextLabel.text = note?.roaster
        coffeeNameTextLabel.text = note?.coffeeName
        originTextLabel.text = note?.origin
        grindTextLabel.text = note?.grind
        methodTextLabel.text = note?.method
        notesTextLabel.text = note?.tastingNotes
    }
}
