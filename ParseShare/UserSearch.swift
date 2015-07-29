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
                    //println(results)
                    if results.count == 0 {
                        self.state = .NoResults
                    } else {
                        // Read Results into UserSearchResult Array
                        // Dont show self in results
                        // If user has already accepted a request, dont show
                        // If they have already invited, show Pending instead of button
                    
                        var userSearchResults = [UserSearchResult]()
                        var searchResult = UserSearchResult()
                        
                        for result in results {
                            if result.objectId != PFUser.currentUser()?.objectId {
                                // Query invites table to see if they already are accepted with user
                                // or if a pending invite exists
                                // Set invite or accepted respectively
                                searchResult.displayName = result["displayName"] as! String
                                searchResult.emailAddress = result["username"] as! String
                                searchResult.inviteUserID = result.objectId!!
                                searchResult.invited = false
                                searchResult.accepted = false
                                userSearchResults.append(searchResult)
                            }
                        }
                        
                        if userSearchResults.count > 0 {
                            self.state = .Results(userSearchResults)
                        } else {
                            self.state = .NoResults
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