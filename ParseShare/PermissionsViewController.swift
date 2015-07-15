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

        // Do any additional setup after loading the view.
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
        case .Results:
            return 1
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
            let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.searchResultCell, forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel!.text = "Found something"
            
            //let searchResult = list[indexPath.row]
            //cell.configureForSearchResult(searchResult)
            
            return cell
        }
    }
}
