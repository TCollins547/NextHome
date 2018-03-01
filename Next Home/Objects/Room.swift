//
//  Room.swift
//  Next Home
//
//  Created by Tyler Collins on 2/9/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Room: NSObject, NSCoding {
    
    var roomIdentifier: String!
    
    var roomName: String!
    var roomBudget = 0
    var roomRunningTab = 0
    var roomRemainingBudget = 0
    var roomType: String!
    
    var roomProject: Project!
    var roomMaterials: [Material] = []
    
    
    struct Keys {
        static let id = "roomID"
        static let name = "roomName"
        static let budget = "roomBudget"
        static let type = "roomType"
        static let project = "roomParent"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let roomIDObj = aDecoder.decodeObject(forKey: Keys.id) as? String { roomIdentifier = String(roomIDObj) }
        if let roomNameObj = aDecoder.decodeObject(forKey: Keys.name) as? String { roomName = String(roomNameObj) }
        if let roomBudgetObj = aDecoder.decodeObject(forKey: Keys.budget) as? Int { roomBudget = Int(roomBudgetObj) }
        if let roomTypeObj = aDecoder.decodeObject(forKey: Keys.type) as? String { roomType = String(roomTypeObj) }
        if let roomProjectObj = aDecoder.decodeObject(forKey: Keys.project) as? Project { roomProject = roomProjectObj }
        
        calcValues()
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(roomIdentifier, forKey: Keys.id)
        aCoder.encode(roomName, forKey: Keys.name)
        aCoder.encode(roomBudget, forKey: Keys.budget)
        aCoder.encode(roomType, forKey: Keys.type)
        aCoder.encode(roomProject, forKey: Keys.project)
    }
    
    
    init(name: String, budget: String, type: String, project: Project) {
        super.init()
        
        roomIdentifier = UUID().uuidString
        
        roomName = name
        
        var budgetInt = budget.replacingOccurrences(of: "$", with: "")
        budgetInt = budgetInt.replacingOccurrences(of: ",", with: "")
        roomBudget = Int(budgetInt)!
        roomRemainingBudget = Int(budgetInt)!
        roomRunningTab = 0
        
        roomProject = project
    }
    
    func getRoomBudget() -> String {
        return formatNumbers(number: String(roomBudget))
    }
    
    func getRoomTab() -> String {
        return formatNumbers(number: String(roomRunningTab))
    }
    
    func getRoomRemaining() -> String {
        return formatNumbers(number: String(roomRemainingBudget))
    }
    
    func calcValues() {
        
        var total = 0
        for mat in roomMaterials {
            total += Int(mat.materialCost)
        }
        roomRunningTab = total
        
        roomRemainingBudget = roomBudget - roomRunningTab
        
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
