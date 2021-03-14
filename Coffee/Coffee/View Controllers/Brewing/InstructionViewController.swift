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
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var currentStepLabel: UILabel!
    @IBOutlet weak var stepsTableView: UITableView!
    
    // MARK: - Properties
    var guide: Guide?
    var currentStep = 0
    var timer = Timer()
    var counter: Double = 0
    var isPaused: Bool = true {
        didSet {
            if isPaused {
                startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            } else {
                startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTableView.tableFooterView = UIView()
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Custom Methods
    @objc func advanceTimer() {
        guard self.counter > 0 else {
            self.timer.invalidate()
            return
        }
        
        self.counter -= 0.1
        self.timerLabel.text = self.timeAsString(time: self.counter)
    }
    
    func timeAsString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        var fraction = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        if fraction < 0 {
            fraction = 0
        }
        
        let timeString = String(format: "%0.2d:%0.2d.%0.2d", minutes, seconds, fraction)
        return String(timeString.prefix(7))
    }
    
    
    func setupUI() {
        guard let guide = guide, let time = guide.steps[currentStep].time else { return }
        
        title = guide.title
        view.backgroundColor = .background
        
        prevButton.isHidden = true
        prevButton.layer.cornerRadius = prevButton.frame.height / 2
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        startButton.layer.cornerRadius = startButton.frame.height / 2
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.tintColor = .buttonType
        
        stepsTableView.backgroundColor = .textFieldBackground
        currentStepLabel.text = guide.steps[currentStep].text
        
        counter = Double(time)
        timerLabel.text = timeAsString(time: time)
    }
    
    func updateView() {
        guard let guide = guide, let time = guide.steps[currentStep].time else { return }
        currentStepLabel.text = guide.steps[currentStep].text
        prevButton.isHidden = currentStep == 0 ? true : false
        isPaused = true

        if counter != 0 {
            timer.invalidate()
        }
        counter = Double(time)
        
        if time == 0 {
            timerLabel.isHidden = true
        } else {
            timerLabel.isHidden = false
            timerLabel.text = timeAsString(time: time)
        }
    }
    
    // MARK: - Actions
    @IBAction func startButtonTapped(_ sender: Any) {
        isPaused.toggle()
        if isPaused {
            timer.invalidate()
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(advanceTimer),
                                     userInfo: nil,
                                     repeats: true)
        }
    }
    
    @IBAction func prevButtonTapped(_ sender: Any) {
        currentStep -= 1
        updateView()
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBrewNotesVC" {
            guard let destinationVC = segue.destination as? BrewNotesViewController else { return }
            destinationVC.guide = guide
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
