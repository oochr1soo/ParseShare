//
//  ViewController.swift
//  ParseShare
//
//  Created by Chris Clough on 7/9/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit
import Parse
import Bolts

class LoginViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Properties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Hello World!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        // Log user in
        // Verify credentials against Parse
        if emailAddressTextField.text == "cc@cc.com" && passwordTextField.text == "test" {
            performSegueWithIdentifier("HomeSegue", sender: nil)
        }
    }

    @IBAction func signUpButtonPressed(sender: UIButton) {
        // Segue to Signup Form
    }
}

