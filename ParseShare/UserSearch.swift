//
//  UserSearch.swift
//  ParseShare
//
//  Created by Chris Clough on 7/14/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import Foundation
import UIKit

typealias SearchComplete = (Bool) -> Void

class UserSearch {
    
    enum State {
        case NotSearchedYet
        case Loading
        case NoResults
        case Results([UserSearchResult])
    }
    
    private(set) var state: State = .NotSearchedYet
    
    func performSearchForText(text: String, completion: SearchComplete) {
        state = .Loading
        
        // Query Parse
        
        var containsDisplayName = PFQuery(className:"_User")
        containsDisplayName.whereKey("displayName", containsString: text)
        
        var containsUsername = PFQuery(className: "_User")
        containsUsername.whereKey("username", containsString: text)
        
        var query = PFQuery.orQueryWithSubqueries([containsUsername, containsDisplayName])
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            //self.state = .NotSearchedYet
            var success = false
            
            if error == nil {
                // Found results
                // Set Result state to either Results or NoResults
                if let results = results {
                    println(results)
                    if results.count == 0 {
                        self.state = .NoResults
                    } else {
                        // Read Results into UserSearchResult Array
                    
                        var userSearchResults = [UserSearchResult]()
                        
                        for result in results {
                            var searchResult = UserSearchResult()
                            searchResult.displayName = result["displayName"] as! String
                            searchResult.emailAddress = result["username"] as! String
                            searchResult.inviteUserID = result.objectId!!
                            searchResult.invited = false
                            userSearchResults.append(searchResult)
                            
                            self.state = .Results(userSearchResults)
                        }
                    }
                        success = true
                    }
                
                dispatch_async(dispatch_get_main_queue()) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    completion(success)
                }
            } else {
                // Error, print it
                println(error)
            }
        }
    }
}