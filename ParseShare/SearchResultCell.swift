//
//  SearchResultCell.swift
//  ParseShare
//
//  Created by Chris Clough on 7/16/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func addButtonPressed(sender: UIButton) {
        // Create invite
        //let invite = Invites(inviteFromUser: PFUser.currentUser()!, inviteToUser: "userid", pending: true)
        println("addButtonPressed for Tag: \(sender.tag)")
        // Change button to Invited, disabled
    }
    
    func configureForSearchResult(searchResult: UserSearchResult) {
        emailAddress.text = searchResult.emailAddress
        displayName.text = searchResult.displayName
    }
}
