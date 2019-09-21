//
//  StepsViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {
    // MARK: - Properties
//    @IBOutlet weak var stepsTableView: UITableView!
//    var guide: Guide?
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        stepsTableView.delegate = self
//        stepsTableView.dataSource = self
//    }
//
//    // MARK: - Actions
//    @IBAction func doneButtonTapped(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//extension StepsViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let guide = guide else { return 0 }
//            return guide.steps.count
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
