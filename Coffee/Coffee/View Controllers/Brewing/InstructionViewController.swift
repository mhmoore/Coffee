//
//  InstructionViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {
    @IBOutlet weak var methodImage: UIImageView!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var coffeeSlider: UISlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var guide: Guide?
    var currentStep = 0
    var timer = Timer()
    var counter = 0.0
    var progress = Progress(totalUnitCount: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = guide?.title
        updateView()
    }
    @IBAction func coffeeSliderChanged(_ sender: Any) {
        timerLabel.text = "\(coffeeSlider.value)"
        guard let guide = guide else { return }
        guide.coffee = Double(coffeeSlider.value)
    }
    @IBAction func startButtonTapped(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        currentStep += 1
        print(currentStep)
        guard let guide = guide else { return }
        if currentStep != guide.steps.count {
            updateView()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            guard let guide = self.guide,
                let time = guide.steps[self.currentStep].time else { return }
            guard self.counter < Double(time) else { self.timer.invalidate(); return }
            self.counter += 1
            let timeString = self.timeString(time: self.counter)
            self.timerLabel.text = timeString
            
            self.progressView.progress = 0.0
            self.progress.completedUnitCount = 0
            
            self.progress.totalUnitCount = Int64(time)
            self.progress.completedUnitCount += 1
            let progressFloat = Float(self.progress.fractionCompleted)
            self.progressView.setProgress(progressFloat, animated: true)
        })
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
    
    func updateView() {
        guard let guide = guide else { return }
        stepsLabel.text = guide.steps[currentStep].text
        methodImage.image = guide.methodImage
        progressView.transform.scaledBy(x: 1, y: 3)
        coffeeSlider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        if guide.steps[currentStep].timerLabel == true {
            coffeeSlider.isHidden = true
        } else {
            startButton.isHidden = true
            progressView.isHidden = true
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBrewNotesVC" {
            guard let guide = guide,
                let destinationVC = segue.destination as? BrewNotesViewController else { return }
            destinationVC.guide = guide
        }
    }
}
