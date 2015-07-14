//
//  Items.swift
//  ParseShare
//
//  Created by Chris Clough on 7/13/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import Foundation

class Items : PFObject {
    @NSManaged var itemDescription: String
    @NSManaged var user: PFUser
    @NSManaged var publicRead: Bool
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Items.parseClassName())
        
        return query
    }
    
    init(description: String, user: PFUser, publicRead: Bool) {
        super.init()
        
        itemDescription = description
        self.user = user
        self.publicRead = publicRead
        
        let acl = PFACL()
        acl.setPublicReadAccess(publicRead)
        acl.setWriteAccess(true, forUser: self.user)
        acl.setReadAccess(true, forRole: self.user)
        self.ACL = acl
    }
    
    override init() {
        super.init()
    }
}

extension Items: PFSubclassing {
    
    class func parseClassName() -> String {
        return "Items"
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}