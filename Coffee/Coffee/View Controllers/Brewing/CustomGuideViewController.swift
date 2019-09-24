//
//  CustomGuideViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/23/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class CustomGuideViewController: UIViewController {
    
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Custom Methods
    
    func updateViews() {
        guard let guide = guide else { return }
        titleTextField.placeholder = "Title me"
        methodLabel.text = "Method: \(guide.method)"
        coffeeTextField.text = "\(guide.coffee)"
        grindTextField.text = "\(guide.grind)"
        waterLabel.text = "Water: \(totalWater(guide: guide))"
        let ratioNumbers = getRatio(guide: guide)
        ratioLabel.text = "Ratio: \(ratioNumbers.0) : \(ratioNumbers.1)"
        let time = totalTime(guide: guide)
        timeLabel.text = "Time: \(timeAsString(time: time))"
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStepDetailVC" {
            guard let indexPath = stepsTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StepDetailViewController,
                let guide = guide else { return }
                let step = guide.steps[indexPath.row]
            destinationVC.step = step
        }
    }
}

extension CustomGuideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guide?.steps.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        let step = guide?.steps[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = step?.text
        
        return cell
    }
}
