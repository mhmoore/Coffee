//
//  BrewNotesViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class BrewNotesViewController: UIViewController {
    // MARK: - Properties
    var guide: BrewGuide?
    @IBOutlet weak var roasterTextField: UITextField!
    @IBOutlet weak var coffeeNameTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var grindTextField: UITextField!
    @IBOutlet weak var methodTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let roaster = roasterTextField.text,
            let coffeeName = coffeeNameTextField.text,
            let origin = originTextField.text,
            let grind = grindTextField.text,
            let method = methodTextField.text,
            let notes = notesTextView.text else { return }
            
        UserNoteController.shared.saveNote(roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, tastingNotes: notes, method: method) { (success) in
            if success {
                self.presentNotesVC()
            } else {
                print("There was an error saving the note")
            }
        }
    }

    // MARK: - Custom Methods
    func presentNotesVC() {
        DispatchQueue.main.async {
            let notesVC = UIStoryboard(name: "Notes", bundle: nil).instantiateViewController(withIdentifier: "notesVC")
            self.present(notesVC, animated: true, completion: nil)
        }
    }
    
    func loadData() {
        guard let grind = guide?.grind,
            let method = guide?.method else {  return }
        grindTextField.text = grind
        methodTextField.text = method
    }
}
