//
//  Room.swift
//  Next Home
//
//  Created by Tyler Collins on 2/9/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Room {
    
    var roomName: String!
    var roomBudget: String!
    
    var roomProject: Project!
    
    init(name: String, budget: String, project: Project) {
        roomName = name
        roomBudget = budget
        roomProject = project
    }
    
}
