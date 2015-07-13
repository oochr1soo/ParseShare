//
//  ViewController.swift
//  ParseShare
//
//  Created by Chris Clough on 7/9/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Properties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if user is logged in
        // If So, segue to HomeViewController
        
        if let user = PFUser.currentUser() {
            if user.isAuthenticated() {
                performSegueWithIdentifier("HomeSegue", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        // Log user in
        // Verify credentials against Parse
        PFUser.logInWithUsernameInBackground(emailAddressTextField.text, password: passwordTextField.text) { (user, error) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("HomeSegue", sender: nil)
            } else if let error = error {
                println(error)
            }
        }
    }

    @IBAction func signUpButtonPressed(sender: UIButton) {
        // Segue to Signup Form
    }
}

