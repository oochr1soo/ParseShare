//
//  SignUpViewController.swift
//  ParseShare
//
//  Created by Chris Clough on 7/9/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    // Properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        // Sign up User then log them in
        // Segue to Home Screen
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        // Dismiss controller back to login screen
        dismissViewControllerAnimated(true, completion: nil)
    }
}
