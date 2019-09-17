//
//  BrewTimerViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class BrewTimerViewController: UIViewController {
    @IBOutlet weak var stepsTableView: UITableView!
    
    var guide: BrewGuide?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BrewTimerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let guide = guide {
            return guide.steps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        if let guide = guide {
            let steps = StepController.shared.stepsAsStrings(steps: guide.steps)
            let step = steps[indexPath.row]
            cell.textLabel?.text = step
        }
        return cell
    }
}
