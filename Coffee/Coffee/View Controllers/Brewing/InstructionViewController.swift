//
//  InstructionViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var methodImage: UIImageView!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var methodInfoLabel: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var grindImage: UIImageView!
    @IBOutlet weak var grindLabel: UILabel!
    
    var guide: Guide?
    var currentStep = 0
    var timer = Timer()
    var counter: Double = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    // MARK: - Actions
    // Timer Functions
    @IBAction func upButtonTapped(_ sender: Any) {
        guard let guide = guide else { return }
        guide.userGuide = true
        counter += 1
        guide.steps[currentStep].time = counter
        updateView()
    }
    @IBAction func downButtonTapped(_ sender: Any) {
        guard let guide = guide else { return }
        guide.userGuide = true
        counter -= 1
        guide.steps[currentStep].time = counter
        updateView()
    }
    @IBAction func startButtonTapped(_ sender: Any) {
        startTimer()
    }
    // Coffee Functions
    @IBAction func coffeeSliderChanged(_ sender: Any) {
        sliderLabel.text = "\(slider.value)"
        guard let guide = guide else { return }
        guide.userGuide = true
        if guide.steps[currentStep].water != 0.0 {
            guide.steps[currentStep].water = Double(slider.value)
        } else {
            guide.coffee = Double(slider.value)
        }
    }
    // Step Functions
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
    
    // MARK: - Custom Methods
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            guard self.counter > 0 else { self.timer.invalidate(); return }
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
    func updateView() {
        guard let guide = guide else { return }
        title = guide.title
        stepsLabel.text = guide.steps[currentStep].text
        methodImage.image = guide.methodImage
        methodInfoLabel.text = guide.methodInfo
        
        if guide.steps[currentStep].water != 0.0 {
            guard let time = guide.steps[currentStep].time,
                let water = guide.steps[currentStep].water else { return }
            counter = time
            let timeString = timeAsString(time: time)
            sliderLabel.text = String(water)
            timerLabel.text = timeString
            timerLabel.isHidden = false
            grindImage.isHidden = true
            grindLabel.isHidden = true
            startButton.isHidden = false
            upButton.isHidden = false
            downButton.isHidden = false
            slider.isHidden = false
            sliderLabel.isHidden = false
            slider.value = Float(water)
            slider.minimumValue = Float(water - 10)
            slider.maximumValue = Float(water + 10)
        } else if guide.steps[currentStep].coffee != 0.0 {
            sliderLabel.text = String(guide.coffee)
            grindImage.isHidden = false
            grindImage.image = guide.grindImage
            grindLabel.isHidden = false
            grindLabel.text = guide.grind
            timerLabel.isHidden = true
            startButton.isHidden = true
            upButton.isHidden = true
            downButton.isHidden = true
            slider.isHidden = false
            sliderLabel.isHidden = false
            slider.value = Float(guide.coffee)
            slider.minimumValue = Float(guide.coffee - 10)
            slider.maximumValue = Float(guide.coffee + 10)
        } else if guide.steps[currentStep].coffee == 0.0 &&  guide.steps[currentStep].water == 0.0 {
            guard let time = guide.steps[currentStep].time else { return }
            counter = time
            let timeString = timeAsString(time: time)
            timerLabel.text = timeString
            timerLabel.isHidden = false
            grindImage.isHidden = true
            grindLabel.isHidden = true
            startButton.isHidden = false
            slider.isHidden = true
            sliderLabel.isHidden = true
            upButton.isHidden = true
            downButton.isHidden = true
        }
    }
}
