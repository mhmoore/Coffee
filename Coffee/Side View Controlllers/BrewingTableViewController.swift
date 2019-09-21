//
//  BrewingTableViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/20/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class BrewingTableViewController: UITableViewController {

//    // MARK: - Properties
//    
//    let filledGuides = GuideController.shared.separatedGuides.compactMap ( {$0} )
//    let cellID = "brewCell"
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Brewing Guides"
//    }
//
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return filledGuides.count
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "jdsfjaog"
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filledGuides[section].count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? BrewTableViewCell else { return UITableViewCell() }
//        // grabs the section (a.k.a. category)
//        let category = filledGuides[indexPath.section]
//        // within that category, grabs the guide at that indexPath
//        let guide = category[indexPath.row]
//        // sets the cells label and image with the associated guide
//        cell.methodLabel?.text = guide.method
//        cell.methodImageView?.image = guide.methodImage
//        
//        return cell
//    }
//
//    
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toInstructionVC" {
//            guard let indexPath = tableView.indexPathForSelectedRow,
//                let destinationVC = segue.destination as? InstructionViewController else { return }
//            let guide = filledGuides[indexPath.section][indexPath.row]
//            destinationVC.guide = guide
//        }
//    }
 

}
