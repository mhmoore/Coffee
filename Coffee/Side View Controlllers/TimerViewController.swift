//
//  TimerViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
//    // MARK: - Properties
//    @IBOutlet weak var stepsTableView: UITableView!
//    @IBOutlet weak var currentWeightLabel: UILabel!
//    @IBOutlet weak var totalWeightLabel: UILabel!
//    @IBOutlet weak var timerLabel: UILabel!
//    
//    var guide: Guide?
//    var timer = Timer()
//    var counter: TimeInterval = 0
//    var currentStep: Int = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        stepsTableView.delegate = self
//        stepsTableView.dataSource = self
//        startTimer()
//        updateViews()
//    }
//    
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toBrewNotesVC" {
//            guard let destinationVC = segue.destination as? BrewNotesViewController,
//                let guide = guide else { return }
//            destinationVC.guide = guide
//        }
//    }
//    
//    // MARK: - Custom Methods
//    func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
//            guard let guide = self.guide else { return }
//            // Timer Label
//            guard self.counter < guide.totalTime else { self.timer.invalidate(); return }
//            self.counter += 1
//            let timeString = self.timeString(time: self.counter)
//            self.timerLabel.text = timeString
//            // Current weight needing to be to be pour for that step
//            var totalDuration: Double = 0.0
//            let duration1 = guide.steps[self.currentStep].duration
//            if self.currentStep == 0 {
//                totalDuration = Double(duration1)
//            } else {
//                let duration2 = guide.steps[self.currentStep - 1].duration
//                totalDuration = Double(duration1) + Double(duration2)
//            }
//            if self.counter == totalDuration {
//                self.currentStep += 1
//                if let currentWeight = guide.steps[self.currentStep].amountOfWater {
//                    self.currentWeightLabel.text = String(currentWeight)
//                } else {
//                    self.currentWeightLabel.text = "0.0"
//                }
//            }
//            
//            // Total Time Label
//            if self.counter == self.guide?.totalTime {
//                self.timerLabel.text = "Cheers! \nServe and enjoy!"
//            }
//        })
//    }
//    
//    func timeString(time: TimeInterval) -> String {
//        let minutes = Int(time) / 60
//        let seconds = Int(time) % 60
//        let timeString = String(format: "%02d:%02d", minutes, seconds)
//        return timeString
//    }
//    
//    func updateViews() {
//        guard let guide = guide else { return }
//        title = guide.title
//        if let currentWeight = guide.steps[currentStep].amountOfWater {
//            currentWeightLabel.text = String(currentWeight)
//        }
//        totalWeightLabel.text = String(guide.totalWater)
//    }
//}
//
//extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let guide = guide else { return 0 }
//        return guide.steps.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
//        if let guide = guide {
//            let steps = StepController.shared.stepsAsStrings(steps: guide.steps)
//            let step = steps[indexPath.row]
//            cell.textLabel?.text = step
//        }
//        return cell
//    }
}
