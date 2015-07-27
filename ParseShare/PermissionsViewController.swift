//
//  PermissionsViewController.swift
//  ParseShare
//
//  Created by Chris Clough on 7/14/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit

class PermissionsViewController: UIViewController, UITableViewDataSource {
    
    // Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    
    let userSearch = UserSearch()
    
    // Constants
    
    struct TableViewCellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    
    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load different cell XIBs
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch userSearch.state {
        case .NotSearchedYet:
            return 0
        case .NoResults:
            return 1
        case .Loading:
            return 1
        case .Results(let list):
            return list.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch userSearch.state {
        case .NotSearchedYet:
            // Shouldnt reach here
            fatalError("Should never get here")
        case .NoResults:
            return tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.nothingFoundCell, forIndexPath: indexPath) as! UITableViewCell
        case .Loading:
            let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.loadingCell, forIndexPath: indexPath) as! UITableViewCell
            
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            
            return cell
        case .Results(let list):
            let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.searchResultCell, forIndexPath: indexPath) as! SearchResultCell
            
            cell.addButton.tag = indexPath.row
            cell.addButton.addTarget(self, action: "addButtonPressed:", forControlEvents: .TouchUpInside)
            
            let searchResult = list[indexPath.row]
            cell.configureForSearchResult(searchResult)
            
            return cell
        }
    }
    
    func addButtonPressed(sender: UIButton) {
        // Create invite
        
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SearchResultCell
        
        println("addButtonPressed for Tag: \(sender.tag) with Email Address: \(cell.emailAddress.text)")
        
        var query = PFQuery(className:"_User")
        query.whereKey("username", equalTo: cell.emailAddress.text!)
        let results = query.findObjects()
        if let results = results {
            if results.count == 1 {
                for result in results {
                    let invite = Invites(inviteFromUser: PFUser.currentUser()!, inviteToUser: result.objectId!!, pending: true)
                    
                    invite.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                        if succeeded {
                            println("Successfully Invited")
                            
                            // Change button to Invited, disabled
                        } else {
                            println(error)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func performSearch() {
        println("Search started")
        userSearch.performSearchForText(searchBar.text, completion: { success in
        
        self.tableView.reloadData()
            
        })
        
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension PermissionsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        performSearch()
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}
