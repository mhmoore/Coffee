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
    @IBOutlet weak var roasterTextField: UITextField!
    @IBOutlet weak var coffeeNameTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var grindDisplayLabel: UILabel!
    @IBOutlet weak var ratioDisplayLabel: UILabel!
    @IBOutlet weak var methodDisplayLabel: UILabel!
    
    var guide: Guide?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    // MARK: - Actions
    @IBAction func skipButtonTapped(_ sender: Any) {
        guard let guide = guide else { return }
        if GuideController.shared.userGuides == nil && guide.userGuide == true {
            presentAlert()
        } else if let userGuides = GuideController.shared.userGuides {
            if guide.userGuide == true && !userGuides.contains(guide) {
                presentAlert()
            } else {
                presentBrewsVC()
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let roaster = roasterTextField.text,
            let coffeeName = coffeeNameTextField.text,
            let origin = originTextField.text,
            let grind = grindDisplayLabel.text,
            let ratio = ratioDisplayLabel.text,
            let method = methodDisplayLabel.text,
            let notes = notesTextView.text else { return }
        
        UserNoteController.shared.createNote(roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, ratio:ratio, tastingNotes: notes, method: method)
        
        guard let guide = guide else { return }
        if GuideController.shared.userGuides == nil && guide.userGuide == true {
            presentAlert()
        } else if let userGuides = GuideController.shared.userGuides {
            if guide.userGuide == true && !userGuides.contains(guide) {
                presentAlert()
            } else {
                presentBrewsVC()
            }
        }
            
//        UserNoteController.shared.createNote(roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, tastingNotes: notes, method: method)
//        presentNotesVC()
    }

    // MARK: - Custom Methods
    func presentBrewsVC() {
        guard let brewsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "brewsVC") as? BrewCollectionViewController else { return }
        present(brewsVC, animated: true, completion: nil)
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Create a guide?", message: "Would you like to save the changes you made?", preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let guide = self.guide else { return }
            if GuideController.shared.userGuides == nil {
                GuideController.shared.userGuides = []
            }
            GuideController.shared.createGuide(userGuide: guide.userGuide, title: guide.title, grind: guide.grind, grindImage: guide.grindImage, coffee: guide.coffee, ratio: guide.ratio, steps: guide.steps, method: guide.method, methodInfo: guide.methodInfo, methodImage: guide.methodImage)
            self.presentBrewsVC()
        }
        
        let nah = UIAlertAction(title: "Nah", style: .default) { (_) in
            self.presentBrewsVC()
        }
        
        alert.addAction(save)
        alert.addAction(nah)
        present(alert, animated: true, completion: nil)
    }
    
    func loadData() {
        guard let guide = guide else { return }
        
        grindDisplayLabel.text = guide.grind
        ratioDisplayLabel.text = guide.ratio
        methodDisplayLabel.text = guide.method
    }
}
