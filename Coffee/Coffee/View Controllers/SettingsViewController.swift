//
//  SettingsViewController.swift
//  Coffee
//
//  Created by Michael Moore on 10/5/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }

    // MARK: - Actions
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
    
    @IBAction func supportAndFeedbackButtonTapped(_ sender: Any) {
        showMailComposer()
    }
    
    // MARK: - Custom Methods
    func showMailComposer() {
           guard MFMailComposeViewController.canSendMail() else { presentEmailAlert(); return }
           let composer = MFMailComposeViewController()
           composer.mailComposeDelegate = self
           composer.setToRecipients(["craftedbrewapp@gmail.com"])
           composer.setSubject("Support/Feedback")
           composer.setMessageBody("Thank you for reaching out.  We welcome any feedback to help make our app better, and offer support with any issues you may run into!", isHTML: false)
           present(composer, animated: true)
       }
    
    func presentErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: "There was an error sending your email. \(error.localizedDescription)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func presentEmailAlert() {
        let alert = UIAlertController(title: "Error", message: "Unable to access Mail", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

// MARK: - Mail Delegate
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            presentErrorAlert(error: error)
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            break
        case .failed:
            if let error = error {
                presentErrorAlert(error: error)
            }
        case .saved:
            break
        case .sent:
            break
        }
        controller.dismiss(animated: true)
    }
}

