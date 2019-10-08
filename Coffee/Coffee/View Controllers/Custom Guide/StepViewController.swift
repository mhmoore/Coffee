//
//  StepViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/24/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class StepViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // MARK: - Properties
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var instructionTextView: UITextView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var pourButton: UIButton!
    @IBOutlet weak var pourLabel: UILabel!
    @IBOutlet weak var stirButton: UIButton!
    @IBOutlet weak var stirLabel: UILabel!
    @IBOutlet weak var waitButton: UIButton!
    @IBOutlet weak var waitLabel: UILabel!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var otherLabel: UILabel!
    
    
    var step: Step?
    var guide: Guide?
    var stepToggle: Bool = false
    var stepTitle: String = "Pour"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        amountTextField.delegate = self
        durationTextField.delegate = self
        instructionTextView.delegate = self
        if stepToggle == true {
            loadData()
        }
        createToolBar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @IBAction func pourButtonTapped(_ sender: Any) {
        stepTitle = "Pour"
        UIView.animate(withDuration: 0.2) {
            self.pourButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.pourLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.stirButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.stirLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.waitButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.waitLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.otherButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.otherLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.pourLabel.textColor = .accent
            self.stirLabel.textColor = .generalType
            self.waitLabel.textColor = .generalType
            self.otherLabel.textColor = .generalType
        }
//        self.amountLabel.isHidden = false
//        self.amountTextField.isHidden = false
        updateViews()
    }
    @IBAction func stirButtonTapped(_ sender: Any) {
        stepTitle = "Stir"
        UIView.animate(withDuration: 0.2) {
            self.pourButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.pourLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.stirButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.stirLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.waitButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.waitLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.otherButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.otherLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.pourLabel.textColor = .generalType
            self.stirLabel.textColor = .accent
            self.waitLabel.textColor = .generalType
            self.otherLabel.textColor = .generalType
        }
//        self.amountLabel.isHidden = true
//        self.amountTextField.isHidden = true
        updateViews()
    }
    @IBAction func waitButtonTapped(_ sender: Any) {
        stepTitle = "Wait"
        UIView.animate(withDuration: 0.2) {
            self.pourButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.pourLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.stirButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.stirLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.waitButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.waitLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.otherButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.otherLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.pourLabel.textColor = .generalType
            self.stirLabel.textColor = .generalType
            self.waitLabel.textColor = .accent
            self.otherLabel.textColor = .generalType
            
        }
//        self.amountLabel.isHidden = true
//        self.amountTextField.isHidden = true
        updateViews()
    }
    @IBAction func otherButtonTapped(_ sender: Any) {
        stepTitle = "Other"
        UIView.animate(withDuration: 0.2) {
            self.pourButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.pourLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.stirButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.stirLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.waitButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.waitLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.otherButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.otherLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.otherLabel.textColor = .accent
            self.pourLabel.textColor = .generalType
            self.stirLabel.textColor = .generalType
            self.waitLabel.textColor = .generalType
        }
//        self.amountLabel.isHidden = false
//        self.amountTextField.isHidden = false
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
                if instructionTextView.text.isEmpty {
                    let text = "Pour \(water)g of water over \(time) seconds"
                    StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
                } else {
                    guard let text = instructionTextView.text else { return }
                    StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
                }
            case "Stir":
                if instructionTextView.text.isEmpty {
                    let text = "Stir for \(time) seconds"
                    StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
                } else {
                    guard let text = instructionTextView.text else { return }
                    StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
                }
            case "Wait":
                if instructionTextView.text.isEmpty {
                    let text = "Wait for \(time) seconds"
                    StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
                } else {
                    guard let text = instructionTextView.text else { return }
                    StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
                }
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
                if instructionTextView.text.isEmpty {
                    let text = "Pour \(water)g of water over \(time) seconds"
                    StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
                    
                } else {
                    guard let text = instructionTextView.text else { return }
                    StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
                }
            case "Stir":
                if instructionTextView.text.isEmpty {
                    let text = "Stir for \(time) seconds"
                    StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
                } else {
                    guard let text = instructionTextView.text else { return }
                    StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
                }
            case "Wait":
                if instructionTextView.text.isEmpty {
                    let text = "Wait for \(time) seconds"
                    StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
                } else {
                    guard let text = instructionTextView.text else { return }
                    StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
                }
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
        instructionTextView.text = "Place instructions here"
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
    }
}
