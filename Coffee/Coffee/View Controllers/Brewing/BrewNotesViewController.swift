//
//  BrewNotesViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class BrewNotesViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    // MARK: - Properties
    @IBOutlet weak var roasterTextField: UITextField!
    @IBOutlet weak var coffeeNameTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var grindLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!

    var guide: Guide?

//    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        roasterTextField.delegate = self
        coffeeNameTextField.delegate = self
        originTextField.delegate = self
        notesTextView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
//    // MARK: - Actions
    @IBAction func skipButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let roaster = roasterTextField.text, !roaster.isEmpty,
            let coffeeName = coffeeNameTextField.text, !coffeeName.isEmpty,
        let origin = originTextField.text, !origin.isEmpty,
            let grind = grindLabel.text,
            let ratio = ratioLabel.text,
            let method = methodLabel.text,
            let notes = notesTextView.text, !notes.isEmpty,
            let guide = guide else { return }

        NoteController.createNote(guide: guide, roaster: roaster, coffeeName: coffeeName, origin: origin, grind: grind, ratio: ratio, tastingNotes: notes, method: method)
        navigationController?.popToRootViewController(animated: true)
    }
    
//     MARK: - Custom Methods
    func loadData() {
        view.backgroundColor = .background
        guard let guide = guide else { return }
        let ratioNumbers = getRatio(guide: guide)
        grindLabel.text = "\(guide.grind)"
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        for textfield in self.view.subviews where textfield is UITextField {
//            textfield.resignFirstResponder()
//        }
//        notesTextView.resignFirstResponder()
//        return true
//    }
}
