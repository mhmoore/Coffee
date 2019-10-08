//
//  SettingsViewController.swift
//  Coffee
//
//  Created by Michael Moore on 10/5/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }

    @IBAction func privacyButtonTapped(_ sender: Any) {
        if let url = URL(string: "https://sites.google.com/view/craftedbrewapp/home") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func tAndCButtonTapped(_ sender: Any) {
        if let url = URL(string: "https://sites.google.com/view/craftedbrewapp/terms-and-conditions") {
        UIApplication.shared.open(url)
        }
    }
    @IBAction func acknowledgementsButtonTapped(_ sender: Any) {
        if let url = URL(string: "https://sites.google.com/view/craftedbrewapp/acknowledgements") {
        UIApplication.shared.open(url)
        }
    }
    
}
