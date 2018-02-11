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
    var roomRunningTab: String!
    var roomRemainingBudget: String!
    var roomArea: String!
    
    var roomProject: Project!
    
    init(name: String, budget: String, area: String, project: Project) {
        roomName = name
        roomBudget = formatNumbers(number: budget)
        roomRunningTab = "0"
        roomRemainingBudget = budget
        roomArea = area
        
        roomProject = project
    }
    
    func formatNumbers(number: String) -> String {
        let num = Int(number)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return numberFormatter.string(from: NSNumber(value:num!))!
    }
    
}
