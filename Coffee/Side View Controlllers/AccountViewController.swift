//
//  AccountViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/14/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
   
//    // MARK: - Properties
//    @IBOutlet weak var nameTextLabel: UILabel!
//    @IBOutlet weak var emailTextLabel: UILabel!
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadData()
//    }
//    
//    // MARK: - Actions
//    @IBAction func logoutButtonTapped(_ sender: Any) {
//        logout()
//    }
//    
//    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
//        deleteAccountAlert()
//    }
//    
//    // MARK: - Custom Methods
//    func loadData() {
//        if let currentUser = UserController.shared.currentUser {
//            nameTextLabel.text = currentUser.name
//            emailTextLabel.text = currentUser.email
//        } // TODO: else if there isn't a currentUser display sign up
//    }
//    
//    func deleteAccountAlert() {
//        let alert = UIAlertController(title: "Delete Account?", message: "Are you sure you'd like to delete your account?", preferredStyle: .alert)
//        let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
//            guard let currentUser = UserController.shared.currentUser else { return }
//            UserController.shared.deleteUser(user: currentUser, completion: { (success) in
//                if success {
//                    DispatchQueue.main.async {
//                        // TODO: present main viewController
//                    }
//                }
//            })
//        }
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alert.addAction(delete)
//        alert.addAction(cancel)
//        present(alert, animated: true, completion: nil)
//    }
//    
//    func logout() {
//        // TODO: complete logout function
//    }
}
