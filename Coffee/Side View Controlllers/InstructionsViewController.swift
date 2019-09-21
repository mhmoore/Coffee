//
//  InstructionsViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
//    // MARK: - Properties
//    @IBOutlet weak var methodImageView: UIImageView!
//    @IBOutlet weak var methodInfoLabel: UILabel!
//    @IBOutlet weak var grindTextLabel: UILabel!
//    @IBOutlet weak var coffeeTextLabel: UILabel!
//    @IBOutlet weak var waterTextLabel: UILabel!
//    
//    var guide: Guide?
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = guide?.method
//        updateViews()
//    }
//    
//    // MARK: - Actions
//    @IBAction func editButtonTapped(_ sender: Any) {
//        guard let createGuideVC = UIStoryboard(name: "Brew", bundle: nil).instantiateViewController(withIdentifier: "createGuideVC") as? CreateGuideViewController,
//        let guide = guide else { return }
//        createGuideVC.guide = guide
//        present(createGuideVC, animated: true, completion: nil)
//    }
//    @IBAction func prepButtonTapped(_ sender: Any) {
//        guard let prepVC = UIStoryboard(name: "Brew", bundle: nil).instantiateViewController(withIdentifier: "prepVC") as? PrepViewController,
//        let guide = guide else { return }
//        prepVC.guide = guide
//        present(prepVC, animated: true)
//    }
//    @IBAction func stepsButtonTapped(_ sender: Any) {
//        guard let stepsVC = UIStoryboard(name: "Brew", bundle: nil).instantiateViewController(withIdentifier: "stepsVC") as? StepsViewController,
//        let guide = guide else { return }
//        stepsVC.guide = guide
//        present(stepsVC, animated: true)
//    }
//    
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toBrewTimerVC" {
//            guard let destinationVC = segue.destination as? TimerViewController,
//            let guide = guide else { return }
//            destinationVC.guide = guide
//        }
//    }
//    
//    // MARK: - Custom Methods
//    func updateViews() {
//        guard let guide = guide else { return }
//        methodImageView.image = guide.methodImage
//        methodInfoLabel.text = guide.methodInfo
//        grindTextLabel.text = guide.grind
//        coffeeTextLabel.text = "\(guide.coffee)g"
//        waterTextLabel.text = "\(guide.totalWater)g"
//    }
}
