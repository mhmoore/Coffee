//
//  StepViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/24/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class StepViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // MARK: - Outlets
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
    
    // MARK: - Properties
    var step: Step?
    var guide: Guide?
    var stepToggle: Bool = false
    var stepTitle: String = ""
    
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
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
        updateViews()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let guide = guide else { return }
        let timeText = durationTextField.text ?? "0.0"
        let time = TimeInterval(timeText) ?? 0.0
        let waterText = amountTextField.text ?? "0.0"
        let water = Double(waterText)
        
        if time < 0.0 || time > 0.0 && time < 1.0 {
            let alert = UIAlertController(title: "Invalid Time", message: "Please ensure time is greater than 1 second before saving", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(okay)
            present(alert, animated: true)
            return
        }
        
        if instructionTextView.text.isEmpty || instructionTextView.text == "Place instructions here" {
            let alert = UIAlertController(title: "Need Instructions", message: "Please provide instructions for this step before saving", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(okay)
            present(alert, animated: true)
            return
        }
        
        if stepTitle == "" {
            let alert = UIAlertController(title: "Please select a step before saving", message: "Pour, Stir, Wait, or Other", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(okay)
            present(alert, animated: true)
            return
        }
        
        if stepToggle == false {
            switch stepTitle {
            case "Pour":
                guard let text = instructionTextView.text else { return }
                StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Stir":
                guard let text = instructionTextView.text else { return }
                StepController.createStep(guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Wait":
                guard let text = instructionTextView.text else { return }
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
                guard let text = instructionTextView.text else { return }
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Stir":
                guard let text = instructionTextView.text else { return }
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Wait":
                guard let text = instructionTextView.text else { return }
                StepController.update(step: step, guide: guide, title: stepTitle, water: water, time: time, text: text)
            case "Other":
                guard let text = instructionTextView.text else { return }
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
        amountTextField.isUserInteractionEnabled = stepTitle == "Pour" || stepTitle == "Other" ? true : false
    }
    
    func loadData() {
        guard let step = step,
            let water = step.water,
            let time = step.time else { return }
        amountTextField.text = "\(water)"
        durationTextField.text = "\(time)"
        instructionTextView.text = step.text
        stepTitle = step.title
        amountTextField.isUserInteractionEnabled = stepTitle == "Pour" || stepTitle == "Other" ? true : false
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
        view.frame.origin.y = 0
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            view.frame.origin.y = -(keyboardHeight / 2)
        }
    }
}
