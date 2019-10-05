//
//  SettingsViewController.swift
//  Coffee
//
//  Created by Michael Moore on 10/5/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var acknowledgementsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acknowledgementsLabel.text = """
        The brew guides provided in this app are based on the brewing methods of Stumptown Coffee Roasters.  They are meant as a guide to be tweaked to your liking.  Get creative, and discover the perfect method for you.
        
        The water droplets icon was created by Milinda Courey and obtained from the Noun Project
        
        The clock icon was created by Three Six Five and obtained from the Noun Project
        
        The spoon icon was created by Cattaleeya Thongsriphong and obtained from the Noun Project
        
        Thank you to all for your sharing your creative gift.
        """
    }

    @IBAction func privacyButtonTapped(_ sender: Any) {
        if let url = URL(string: "https://sites.google.com/view/craftedbrewapp/home") {
            UIApplication.shared.open(url)
        }
    }
    
}
