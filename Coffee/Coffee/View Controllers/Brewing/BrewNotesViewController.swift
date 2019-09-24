//
//  BrewNotesViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class BrewNotesViewController: UIViewController {
//    // MARK: - Properties
    @IBOutlet weak var roasterTextField: UITextField!
    @IBOutlet weak var coffeeNameTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var grindLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
//
    var guide: Guide?
//
//    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
//    // MARK: - Actions
    @IBAction func skipButtonTapped(_ sender: Any) {
        presentBrewsVC()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let roaster = roasterTextField.text,
            let coffeeName = coffeeNameTextField.text,
            let origin = originTextField.text,
            let grind = grindLabel.text,
            let ratio = ratioLabel.text,
            let method = methodLabel.text,
            let notes = notesTextView.text,
            let guide = guide else { return }

        NoteController.createNote(guide: guide, roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, ratio: ratio, tastingNotes: notes, method: method)
        presentBrewsVC()
    }
    
    // MARK: - Custom Methods
    func presentBrewsVC() {
        guard let brewsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC") as? MainViewController else { return }
        present(brewsVC, animated: true)
    }
//
//    func saveAlert() {
//        let alert = UIAlertController(title: "Create a guide?", message: "Would you like to save the changes you made?", preferredStyle: .alert)
//        let yes = UIAlertAction(title: "Yes please", style: .default) { (_) in
//            self.titleAlert()
//        }
//        let nah = UIAlertAction(title: "Nah", style: .default) { (_) in
//            self.presentBrewsVC()
//        }
//        alert.addAction(yes)
//        alert.addAction(nah)
//        present(alert, animated: true, completion: nil)
//    }
//
//    func titleAlert() {
//        let alert = UIAlertController(title: "Give it a title", message: nil, preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.placeholder = "Title your guide"
//        }
//        let textField = alert.textFields?.first
//        let save = UIAlertAction(title: "Save", style: .default) { (_) in
//            guard let guide = self.guide else { return }
//            if let text = textField?.text, !text.isEmpty {
//                guide.title = text
//            }
//            if GuideController.shared.userGuides == nil {
//                GuideController.shared.userGuides = []
//            }
//            GuideController.shared.createGuide(userGuide: guide.userGuide, title: guide.title, grind: guide.grind, grindImage: guide.grindImage, coffee: guide.coffee, ratio: guide.ratio, steps: guide.steps, method: guide.method, methodInfo: guide.methodInfo, methodImage: guide.methodImage)
//            self.presentBrewsVC()
//        }
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
//            self.presentBrewsVC()
//        }
//        alert.addAction(save)
//        alert.addAction(cancel)
//        present(alert, animated: true)
//    }
//
    func loadData() {
        guard let guide = guide else { return }
        let ratioNumbers = getRatio(guide: guide)
        grindLabel.text = guide.grind
        ratioLabel.text = "\(ratioNumbers.0) : \(ratioNumbers.1)"
        methodLabel.text = guide.method
    }
    
    func totalWater(guide: Guide) -> Double {
        var array: [Double] = []
        for step in guide.steps {
            guard let water = step.water else { return 0.0 }
            array.append(water)
        }
        return array.reduce(0, +)
    }
    
    func getRatio(guide: Guide) -> (Int, Int) {
        var coffee = Int(guide.coffee)
        var water = Int(totalWater(guide: guide))
        let result = gcd(coffee, water)
        coffee = coffee / result
        water = water / result
        return (coffee, water)
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        let remainder = a % b
        if remainder != 0 {
            return gcd(b, remainder)
        } else {
            return b
        }
    }
}
