//
//  ItemDetailsViewController.swift
//  ParseShare
//
//  Created by Chris Clough on 7/13/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var itemDescriptionTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard:"))
        gestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(gestureRecognizer)
        
        itemDescriptionTextfield.delegate = self
        
        itemDescriptionTextfield.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableView Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            itemDescriptionTextfield.becomeFirstResponder()
        }
    }
    
    // MARK: - Helper Methods
    
    func hideKeyboard(gestureRecognizer: UIGestureRecognizer) {
        let point = gestureRecognizer.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        
        if indexPath != nil && indexPath!.section == 0 && indexPath!.row == 0 {
            return
        }
        
        itemDescriptionTextfield.resignFirstResponder()
    }
    
    func saveItem() {
        let item = Items(description: itemDescriptionTextfield.text, user: PFUser.currentUser()!)
        item.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                println(error)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        itemDescriptionTextfield.resignFirstResponder()
        
        saveItem()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        itemDescriptionTextfield.resignFirstResponder()
        
        return true
        
    }
}
