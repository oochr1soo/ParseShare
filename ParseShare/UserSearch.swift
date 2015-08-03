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
    var pendingInvite = false
    
    func performSearchForText(text: String, completion: SearchComplete) {
        state = .Loading
        
        // Query Parse
        
        var containsDisplayName = PFQuery(className:"_User")
        containsDisplayName.whereKey("displayName", containsString: text)
        containsDisplayName.whereKey("objectId", notEqualTo: PFUser.currentUser()!.objectId!)
        
        var containsUsername = PFQuery(className: "_User")
        containsUsername.whereKey("username", containsString: text)
        containsUsername.whereKey("objectId", notEqualTo: PFUser.currentUser()!.objectId!)
        
        var query = PFQuery.orQueryWithSubqueries([containsUsername, containsDisplayName])
        query.includeKey("inviteFromUser")
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
                        // If user has already accepted a request, dont show
                        // If they have already invited, show Pending instead of button
                    
                        var userSearchResults = [UserSearchResult]()
                        
                        for result in results {
                            println(result)
                            var searchResult = UserSearchResult()
                            searchResult.displayName = result["displayName"] as! String
                            searchResult.emailAddress = result["username"] as! String
                            searchResult.inviteUserID = result.objectId!!
                            searchResult.invited = self.pendingInvite
                            searchResult.accepted = false
                            userSearchResults.append(searchResult)
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