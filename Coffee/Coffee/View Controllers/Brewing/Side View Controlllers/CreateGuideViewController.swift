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
    
    var guide: Guide?
    var totalTime: TimeInterval = 0.0
    var totalWater: Double = 0.0
    var newSteps: [Step] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func stepTypeSelected(_ sender: Any) {
        update(view: addStepView)
    }
    
    @IBAction func addStepButtonTapped(_ sender: Any) {
        let type = stepTypeSegmentedControl.selectedSegmentIndex
        guard let time = TimeInterval(timeTextField.text!) else { return }
        totalTime += time
        if type == 0 {
            guard let amount = Double(amountTextField.text!) else { return }
            totalWater += amount
            let newStep = StepController.shared.createStep(time: time, amount: amount, type: .pour)
            newSteps.append(newStep)
        } else if type == 1 {
            let newStep = StepController.shared.createStep(time: time, amount: nil, type: .stir)
            newSteps.append(newStep)
        } else {
            let newStep = StepController.shared.createStep(time: time, amount: nil, type: .wait)
            newSteps.append(newStep)
        }
        updateViews()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        stepsTableView.isEditing = !stepsTableView.isEditing
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        guard let brewInstructionVC = UIStoryboard(name: "Brew", bundle: nil).instantiateViewController(withIdentifier: "brewInstructionVC") as? InstructionsViewController else { return }
        brewInstructionVC.guide = guide
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let guide = guide,
            let title = titleTextField.text,
            let grind = grindTextField.text,
            let coffee = Double(coffeeTextField.text!) else { return }
        GuideController.shared.createGuide(title: title, grind: grind, coffee: coffee, prep: guide.prep, steps: newSteps, method: guide.method, methodInfo: guide.methodInfo, methodImage: guide.methodImage)
        presentInstructionVC()
    }
    
    
    // MARK: - Custom Methods
    func presentInstructionVC() {
        DispatchQueue.main.async {
            guard let brewInstructionVC = UIStoryboard(name: "Brew", bundle: nil).instantiateViewController(withIdentifier: "brewInstructionVC") as? InstructionsViewController else { return }
            brewInstructionVC.guide = self.guide
            self.dismiss(animated: true, completion: nil)
        }
    }
    
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
        totalTimeTextLabel.text = String(totalTime)
        totalWaterTextLabel.text = String(totalWater)
        update(view: addStepView)
        self.stepsTableView.reloadData()
        stepsTableView.isEditing = false
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
            let step = newSteps[indexPath.row]
            if let amount = step.amountOfWater {
                totalWater -= amount
            }
            totalTime -= step.duration
            newSteps.remove(at: indexPath.row)
            stepsTableView.deleteRows(at: [indexPath], with: .fade)
            updateViews()
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
