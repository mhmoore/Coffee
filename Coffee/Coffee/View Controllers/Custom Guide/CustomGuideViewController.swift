//
//  CustomGuideViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/23/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class CustomGuideViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var coffeeTextField: UITextField!
    @IBOutlet weak var grindTextField: UITextField!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepsTableView: UITableView!
    
    var guide: Guide?
    var coffeeRange: [String] = []
    let grinds = ["Fine",
                  "Medium-Fine",
                  "Medium",
                  "Medium-Coarse",
                  "Coarse",
                  "Extra Coarse"]
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        titleTextField.delegate = self
        coffeeTextField.delegate = self
        grindTextField.delegate = self
        stepsTableView.isEditing = false
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stepsTableView.reloadData()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
        stepsTableView.isEditing = !stepsTableView.isEditing
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let guide = guide,
            let title = titleTextField.text, !title.isEmpty else { return }
        guide.title = title
        
        if GuideController.shared.userGuides == nil {
            GuideController.shared.userGuides = []
            GuideController.shared.userGuides?.append(guide)
        } else {
            GuideController.shared.userGuides?.append(guide)
        }
    }
    
    // MARK: - Custom Methods
//    func updateViews() {
//        guard let guide = guide else { return }
//        waterLabel.text = "Water: \(totalWater(guide: guide))"
//        let ratioNumbers = getRatio(guide: guide)
//        ratioLabel.text = "Ratio: \(ratioNumbers.0) : \(ratioNumbers.1)"
//        let time = totalTime(guide: guide)
//        timeLabel.text = "Time: \(timeAsString(time: time))"
//    }
    
    func updateViews() {
        guard let guide = guide else { return }
        methodLabel.text = "Method: \(guide.method)"
        titleTextField.placeholder = "Title me"
        grindTextField.text = guide.grind
        coffeeTextField.text = String(guide.coffee)
        waterLabel.text = "Water: \(totalWater(guide: guide))"
        let ratioNumbers = getRatio(guide: guide)
        ratioLabel.text = "Ratio: \(ratioNumbers.0) : \(ratioNumbers.1)"
        let time = totalTime(guide: guide)
        timeLabel.text = "Time: \(timeAsString(time: time))"
        createGrindPicker()
        createCoffeePicker()
        createToolBar()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return titleTextField.resignFirstResponder()
    }
    
    func totalWater(guide: Guide) -> Double {
        var array: [Double] = []
        for step in guide.steps {
            guard let water = step.water else { return 0.0 }
            array.append(water)
        }
        return array.reduce(0, +)
    }
    
    func totalTime(guide: Guide) -> TimeInterval {
        var array: [TimeInterval] = []
        for step in guide.steps {
            guard let time = step.time else { return 0.0 }
            array.append(time)
        }
        return array.reduce(0, +)
    }
    
    func timeAsString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
    
    func getRatio(guide: Guide) -> (Int, Int) {
        var coffee = Int(guide.coffee)
        var water = Int(totalWater(guide: guide))
        let result = gcd(coffee, water)
        if result == 0 {
            return (0,0)
        }
        coffee = coffee / result
        water = water / result
        return (coffee, water)
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        if a == 0 || b == 0 {
            return 0
        }
        let remainder = a % b
        if remainder != 0 {
            return gcd(b, remainder)
        } else {
            return b
        }
    }
    
    func createCoffeePicker() {
        guard let guide = guide else { return }
        var i = 0.3
        while i <= 3.0 {
            let less = round((guide.coffee - i) * 10) / 10
            coffeeRange.insert(String(less), at: 0)
            let more = round((guide.coffee + i) * 10) / 10
            coffeeRange.append(String(more))
            i += 0.3
        }
        let coffeePicker = UIPickerView()
        coffeePicker.backgroundColor = .white
        coffeePicker.delegate = self
        coffeeTextField.inputView = coffeePicker
    }
    
    func createGrindPicker() {
        let grindPicker = UIPickerView()
        grindPicker.backgroundColor = .white
        grindPicker.delegate = self
        grindTextField.inputView = grindPicker
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = .white
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        grindTextField.inputAccessoryView = toolBar
        coffeeTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editStepSegue" {
            guard let indexPath = stepsTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? AddStepViewController,
                let guide = guide else { return }
            let step = guide.steps[indexPath.row]
            destinationVC.guide = guide
            destinationVC.step = step
            destinationVC.stepToggle = true
        } else if segue.identifier == "addStepSegue" {
            guard let destinationVC = segue.destination as? AddStepViewController,
                let guide = guide else { return }
            destinationVC.guide = guide
        } else if segue.identifier == "toIntroVC" {
            guard let destinationVC = segue.destination as? GuideIntroViewController,
                let guide = guide else { return }
            destinationVC.guide = guide
        }
    }
}

extension CustomGuideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guide?.steps.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        guard let guide = guide else { return UITableViewCell() }
        let step = guide.steps[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = step.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let guide = guide else { return }
            let step = guide.steps[indexPath.row]
            GuideController.shared.remove(step: step, from: guide)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateViews()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let guide = guide else { return }
        if stepsTableView.isEditing == true {
            let step = guide.steps[sourceIndexPath.row]
            guide.steps.remove(at: sourceIndexPath.row)
            guide.steps.insert(step, at: destinationIndexPath.row)
        }
    }
}

extension CustomGuideViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if grindTextField.isEditing {
            return grinds.count
        } else if coffeeTextField.isEditing {
            return coffeeRange.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if grindTextField.isEditing {
            return grinds[row]
        } else if coffeeTextField.isEditing {
            return coffeeRange[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if grindTextField.isEditing {
            guard let guide = guide else { return }
            grindTextField.text = grinds[row]
            guide.grind = grinds[row]
        } else if coffeeTextField.isEditing {
            guard let guide = guide,
                let selectedCoffee = Double(coffeeRange[row]) else { return }
            coffeeTextField.text = coffeeRange[row]
            guide.coffee = selectedCoffee
            updateViews()
        }
    }
}
