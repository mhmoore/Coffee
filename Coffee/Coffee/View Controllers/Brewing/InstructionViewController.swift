//
//  InstructionViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var currentStepLabel: UILabel!
    @IBOutlet weak var stepsTableView: UITableView!
    
    // MARK: - Properties
    var guide: Guide?
    var currentStep = 0
    var timer = Timer()
    var counter: Double = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTableView.tableFooterView = UIView()
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        updateView()
    }
    
    // MARK: - Custom Methods
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            guard self.counter > 0 else { self.timer.invalidate(); self.nextButton.isHidden = false; self.startButton.isUserInteractionEnabled = true; return }
            self.nextButton.isHidden = true
            self.startButton.isUserInteractionEnabled = false
            self.counter -= 1
            print(self.counter)
            let timeString = self.timeAsString(time: self.counter)
            self.timerLabel.text = timeString
        })
    }
    func timeAsString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBrewNotesVC" {
            guard let destinationVC = segue.destination as? BrewNotesViewController else { return }
            destinationVC.guide = guide
        }
    }
    
    func updateView() {
        view.backgroundColor = .background
        stepsTableView.backgroundColor = .textFieldBackground
        guard let guide = guide,
            let time = guide.steps[currentStep].time else { return }
        title = guide.title
        currentStepLabel.text = guide.steps[currentStep].text
        counter = Double(time)
        timerLabel.text = timeAsString(time: time)
        if guide.steps[currentStep].time == 0.0 {
                self.timerLabel.isHidden = true
                self.startButton.isHidden = true
        }
    }
    
    // MARK: - Actions
    @IBAction func startButtonTapped(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let guide = guide else { return }
        if (currentStep + 1) == guide.steps.count {
            performSegue(withIdentifier: "toBrewNotesVC", sender: nextButton)
        } else {
            currentStep += 1
            updateView()
        }
    }
}

    // MARK: - TableView Delegate and DataSource
extension InstructionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guide?.steps.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath) as? InstructionStepTableViewCell,
        let guide = guide else { return UITableViewCell() }
        let step = guide.steps[indexPath.row]
        cell.step = step
        return cell
    }
}
