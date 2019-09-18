//
//  CreateGuideViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class CreateGuideViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var grindTextField: UITextField!
    @IBOutlet weak var coffeeTextField: UITextField!
    @IBOutlet weak var totalWaterTextLabel: UILabel!
    @IBOutlet weak var totalTimeTextLabel: UILabel!
    @IBOutlet weak var stepsTableView: UITableView!
    @IBOutlet weak var addStepView: UIView!
    @IBOutlet weak var stepTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var stepTextLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var gramsTextLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    var guide: BrewGuide?
    var totalTime: String?
    var totalWater: String?
    var newSteps: [Step] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.isEditing = false
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func stepTypeSelected(_ sender: Any) {
        update(view: addStepView)
    }
    
    @IBAction func addStepButtonTapped(_ sender: Any) {
        guard let stepTypeSegmentedControl = stepTypeSegmentedControl else { return }
        let type = stepTypeSegmentedControl.selectedSegmentIndex
        guard let time = timeTextField.text,
            let amount = amountTextField.text else { return }
        
        if type == 0 {
            let newStep = StepController.shared.createStep(time: time, amount: amount, type: .pour)
            newSteps.append(newStep)
        } else if type == 1 {
            let newStep = StepController.shared.createStep(time: time, amount: nil, type: .stir)
            newSteps.append(newStep)
        } else {
            let newStep = StepController.shared.createStep(time: time, amount: nil, type: .wait)
            newSteps.append(newStep)
        }
        update(view: addStepView)
        self.stepsTableView.reloadData()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
       stepsTableView.isEditing = !stepsTableView.isEditing
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        if stepsTableView.isEditing == true {
            stepsTableView.isEditing = false
        }
        guard let brewInstructionVC = UIStoryboard(name: "Brew", bundle: nil).instantiateViewController(withIdentifier: "brewInstructionVC") as? BrewInstructionViewController else { return }
        brewInstructionVC.guide = guide
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if stepsTableView.isEditing == true {
            stepsTableView.isEditing = false
        }
        guard let totalWater = totalWater,
            let totalTime = totalTime,
            let title = titleTextField.text,
            let grind = titleTextField.text,
            let coffeeAmount = coffeeTextField.text,
            let method = guide?.method,
            let methodInfo = guide?.methodInfo,
            let methodImage = guide?.methodImage,
            let steps = guide?.steps,
            let prep = guide?.prep else { return }

        BrewGuideController.shared.saveGuide(userGuide: true, title: title, grind: grind, coffeeAmount: coffeeAmount, waterAmount: totalWater, prep: prep, steps: steps, method: method, methodInfo: methodInfo, methodImage: methodImage, time: totalTime) { (success) in
            if success {
                guard let brewInstructionVC = UIStoryboard(name: "Brew", bundle: nil).instantiateViewController(withIdentifier: "brewInstructionVC") as? BrewInstructionViewController else { return }
                brewInstructionVC.guide = self.guide
                self.dismiss(animated: true, completion: nil)
            } else {
                print("There was an error saving the User's Guide")
            }
        }
    }
    
    // MARK: - Custom Methods
    func update(view: UIView) {
        guard let stepTypeSegmentedControl = stepTypeSegmentedControl else { return }
        let type = stepTypeSegmentedControl.selectedSegmentIndex
        if type == 0 {
            stepTextLabel.text = "How much water would you like to pour over how many seconds?"
            timeTextField.text = ""
            amountTextField.text = ""
            amountTextField.isHidden = false
            gramsTextLabel.isHidden = false
        } else if type == 1 {
            stepTextLabel.text = "How many seconds would you like to stir?"
            timeTextField.text = ""
            amountTextField.text = ""
            amountTextField.isHidden = true
            gramsTextLabel.isHidden = true
        } else {
            stepTextLabel.text = "How many seconds would you like to wait and let bloom?"
            timeTextField.text = ""
            amountTextField.text = ""
            amountTextField.isHidden = true
            gramsTextLabel.isHidden = true
        }
    }
    
    func updateViews() {
        update(view: addStepView)
    }
}

extension CreateGuideViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        let stepStrings = StepController.shared.stepsAsStrings(steps: newSteps)
        let step = stepStrings[indexPath.row]
        cell.textLabel?.text = step
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            newSteps.remove(at: indexPath.row)
            stepsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if stepsTableView.isEditing == true {
            let row = newSteps[sourceIndexPath.row]
            newSteps.remove(at: sourceIndexPath.row)
            newSteps.insert(row, at: destinationIndexPath.row)
        }
    }
}
