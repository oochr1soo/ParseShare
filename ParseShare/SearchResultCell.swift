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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addButton(sender: UIButton) {
        // Create invite 
    }
}