//
//  Room.swift
//  Next Home
//
//  Created by Tyler Collins on 2/9/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Room: Equatable {
    
    var roomIdentifier: String!
    
    var roomName: String!
    var roomBudget: String!
    var roomRunningTab: String!
    var roomRemainingBudget: String!
    var roomType: RoomType!
    
    var roomProject: Project!
    
    init(name: String, budget: String, type: String, project: Project) {
        
        roomIdentifier = UUID().uuidString
        
        roomName = name
        roomBudget = formatNumbers(number: budget)
        roomRunningTab = "0"
        roomRemainingBudget = budget
        //roomArea = area
        
        roomProject = project
    }
    
    func formatNumbers(number: String) -> String {
        let num = Int(number)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return numberFormatter.string(from: NSNumber(value:num!))!
    }
    
    static func == (lhs: Room,rhs: Room) -> Bool {
        return lhs.roomIdentifier == rhs.roomIdentifier
    }
    
}

public enum RoomType {
    case Bedroom
    case Bathroom
    case LivingRoom
    case other(String)
}
