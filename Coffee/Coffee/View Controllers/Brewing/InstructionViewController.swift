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
    @IBOutlet weak var coffeeSlider: UISlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    
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
        
        timerLabel.text = "\(coffeeSlider.value)"
        guard let guide = guide else { return }
        guide.userGuide = true
        guide.coffee = Double(coffeeSlider.value)
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
        coffeeSlider.minimumValue = Float(guide.coffee - 10)
        coffeeSlider.maximumValue = Float(guide.coffee + 10)
        
        coffeeSlider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        if guide.steps[currentStep].timerLabel == true {
            guard let time = guide.steps[currentStep].time else { return }
            counter = time
            let timeString = timeAsString(time: time)
            timerLabel.text = timeString
            startButton.isHidden = false
            upButton.isHidden = false
            downButton.isHidden = false
            coffeeSlider.isHidden = true
        } else {
            timerLabel.text = "\(guide.coffee)"
            startButton.isHidden = true
            upButton.isHidden = true
            downButton.isHidden = true
            coffeeSlider.isHidden = false
        }
    }
}
