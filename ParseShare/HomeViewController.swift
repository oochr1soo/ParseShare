//
//  HomeViewController.swift
//  ParseShare
//
//  Created by Chris Clough on 7/10/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit

class HomeViewController: PFQueryTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let query = Items.query()
        return query!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? PFTableViewCell
        
//        var separator = CALayer()
//        separator.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.2).CGColor
//        separator.frame = CGRectMake(0, 44, self.view.frame.width, 1)
//        cell!.layer.addSublayer(separator)
        
        let item = object as! Items
        cell!.textLabel!.text = item.itemDescription
        
        return cell
    }

    @IBAction func logoutButtonPressed(sender: UIBarButtonItem) {
        // Clear parse session and pop user back to rootVC
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
