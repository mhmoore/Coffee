//
//  GuideIntroViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/23/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class GuideIntroViewController: UIViewController {
    // MARK: - Properties
    var guide: Guide?
    @IBOutlet weak var methodImage: UIImageView!
    @IBOutlet weak var methodInfo: UILabel!
    @IBOutlet weak var grindImage: UIImageView!
    @IBOutlet weak var grindLabel: UILabel!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var ratioLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var prepLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInstructionVC" {
            guard let destinationVC = segue.destination as? InstructionViewController else { return }
            destinationVC.guide = guide
        } else if segue.identifier == "toCustomVC" {
            guard let destinationVC = segue.destination as? CustomGuideViewController,
                  let guide = guide else { return }
            // makes a copy of guide and steps so that it doesn't make changes to the standard guide
            let stepsCopy = guide.steps.map { step in
                Step(title: step.title, water: step.water, time: step.time, text: step.text)
            }
            let guideCopy = Guide(userGuide: true, title: guide.title, method: guide.method, methodInfo: guide.methodInfo, coffee: guide.coffee, grind: guide.grind, prep: guide.prep, steps: stepsCopy, notes: guide.notes)
            destinationVC.guide = guideCopy
        }
    }
    
    // MARK: - Custom Methods
    func loadData() {
        guard let guide = guide else { return }
        methodInfo.text = guide.methodInfo
        grindLabel.text = guide.grind
        grindImage.layer.cornerRadius = grindImage.frame.height / 2
        coffeeLabel.text = "Coffee: \(guide.coffee)g"
        waterLabel.text = "Water: \(totalWater(guide: guide))g"
        let timeString = timeAsString(time: totalTime(guide: guide))
        timeLabel.text = "Time: \(timeString)"
        let ratioNumbers = getRatio(guide: guide)
        ratioLabel.text = "\(ratioNumbers.0) : \(ratioNumbers.1)"
        prepLabel.text = guide.prep
        
        switch guide.grind {
        case "Fine":
            grindImage.image = UIImage(named: "fine")
        case "Fine-Medium":
            grindImage.image = UIImage(named: "mediumFine")
        case "Medium":
            grindImage.image = UIImage(named: "medium")
        case "Medium-Coarse":
            grindImage.image = UIImage(named: "mediumCoarse")
        case "Coarse":
            grindImage.image = UIImage(named: "coarse")
        case "Extra Coarse" :
            grindImage.image = UIImage(named: "extraCoarse")
        default:
            grindImage.image = nil
        }
        
        switch guide.method {
            case "CHEMEX":
                methodImage.image = UIImage(named: "chemex")
            case "AeroPress":
                methodImage.image = UIImage(named: "aeroPress")
            case "Moka Pot":
                methodImage.image = UIImage(named: "mokaPot")
            case "French Press":
                methodImage.image = UIImage(named: "frenchPress")
            case "Kalita Wave":
                methodImage.image = UIImage(named: "kalita")
            case "Hario V60" :
                methodImage.image = UIImage(named: "v60")
            default:
                methodImage.image = nil
        }
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
}