//
//  PrepViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/16/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class PrepViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var prepLabel: UILabel!
    var guide: Guide?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepLabel.text = guide?.prep
    }
    
    // MARK: - Actions
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
