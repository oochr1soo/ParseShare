//
//  Invites.swift
//  ParseShare
//
//  Created by Chris Clough on 7/27/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import Foundation

class Invites: PFObject {
    @NSManaged var inviteFromUser: PFUser
    @NSManaged var inviteToUser: String
    @NSManaged var pending: Bool
    @NSManaged var accepted: Bool
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Invites.parseClassName())
        
        return query
    }
    
    init(inviteFromUser: PFUser, inviteToUser: String, pending: Bool, accepted: Bool) {
        super.init()
        
        self.inviteFromUser = inviteFromUser
        self.inviteToUser = inviteToUser
        self.pending = pending
        self.accepted = accepted
        
        let acl = PFACL()
        acl.setPublicReadAccess(false)
        acl.setWriteAccess(true, forUser: inviteFromUser)
        acl.setWriteAccess(true, forUserId: inviteToUser)
        acl.setReadAccess(true, forUserId: inviteToUser)
        acl.setReadAccess(true, forUser: inviteFromUser)
        self.ACL = acl
    }
    
    override init() {
        super.init()
    }
}

extension Invites: PFSubclassing {
    
    class func parseClassName() -> String {
        return "Invites"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}