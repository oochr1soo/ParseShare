//
//  UserSearch.swift
//  ParseShare
//
//  Created by Chris Clough on 7/14/15.
//  Copyright (c) 2015 Chris Clough. All rights reserved.
//

import Foundation
import UIKit

class UserSearch {
    
    enum State {
        case NotSearchedYet
        case Loading
        case NoResults
        case Results
    }
    
    private(set) var state: State = .NotSearchedYet
    
    
}
