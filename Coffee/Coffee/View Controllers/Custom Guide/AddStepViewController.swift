//
//  AddStepViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/24/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class AddStepViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // MARK: - Properties
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var instructionTextView: UITextView!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var step: Step?
    var guide: Guide?
    var stepToggle: Bool = false
    var stepTitle: String = "Pour"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
        durationTextField.delegate = self
        instructionTextView.delegate = self
        if stepToggle == true {
            loadData()
        }
        createToolBar()
    }
    
    // MARK: - Actions
    @IBAction func pourButtonTapped(_ sender: Any) {
        stepTitle = "Pour"
        updateViews()
    }
    @IBAction func stirButtonTapped(_ sender: Any) {
        stepTitle = "Stir"
        updateViews()
    }
    @IBAction func waitButtonTapped(_ sender: Any) {
        stepTitle = "Wait"
        updateViews()
    }
    @IBAction func otherButtonTapped(_ sender: Any) {
        stepTitle = "Other"
        updateViews()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let guide = guide,
            let timeText = durationTextField.text,
            let time = TimeInterval(timeText) else { return }
        let waterText = amountTextField.text ?? "0"
        let water = Double(waterText) ?? 0
        if stepToggle == false {
            switch stepTitle {
            case "Pour":
                let text = "Pour \(water)g of water over \(time) seconds"
                StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Stir":
                let text = "Stir for \(time) seconds"
                StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Wait":
                let text = "Wait for \(time) seconds"
                StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Other":
                guard let text = instructionTextView.text, !text.isEmpty else { return }
                StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
            default:
                let text = ""
                StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
            }
        } else {
            guard let step = step else { return }
            switch stepTitle {
            case "Pour":
                let text = "Pour \(water)g of water over \(time) seconds"
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Stir":
                let text = "Stir for \(time) seconds"
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Wait":
                let text = "Wait for \(time) seconds"
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Other":
                guard let text = instructionTextView.text, !text.isEmpty else { return }
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            default:
                let text = ""
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Custom Methods
    func updateViews() {
        amountTextField.text = ""
        durationTextField.text = ""
        instructionTextView.text = ""
        
        if stepTitle == "Pour" || stepTitle == "Other" {
            amountTextField.isHidden = false
            amountLabel.isHidden = false
        } else {
            amountTextField.isHidden = true
            amountLabel.isHidden = true
        }
    }
    
    func loadData() {
        guard let step = step,
            let water = step.water,
            let time = step.time else { return }
        amountTextField.text = "\(water)"
        durationTextField.text = "\(time)"
        instructionTextView.text = step.text
        stepTitle = step.title
        
        if stepTitle == "Pour" || stepTitle == "Other" {
            amountTextField.isHidden = false
            amountLabel.isHidden = false
        } else {
            amountTextField.isHidden = true
            amountLabel.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return amountTextField.resignFirstResponder() &&
            durationTextField.resignFirstResponder() &&
            instructionTextView.resignFirstResponder()
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = .white
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        amountTextField.inputAccessoryView = toolBar
        durationTextField.inputAccessoryView = toolBar
        instructionTextView.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        let time = durationTextField.text ?? "0"
        let water = amountTextField.text ?? "0"
        if stepTitle == "Pour" {
            instructionTextView.text = "Pour \(water) grams of water over \(time) seconds"
        } else if stepTitle == "Stir" {
            instructionTextView.text = "Stir for \(time) seconds"
        } else if stepTitle == "Wait" {
            instructionTextView.text = "Wait for \(time) seconds"
        } else {
            instructionTextView.text = ""
        }
    }
}
