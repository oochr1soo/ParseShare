//
//  ItemDetailsViewController.swift
//  ParseShare
//
//  Created by Chris Clough on 7/13/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UITableViewController {

    @IBOutlet weak var itemDescriptionTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
    }
}
