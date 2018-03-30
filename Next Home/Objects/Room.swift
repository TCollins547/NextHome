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
    
    var roomIdentifier: String = String()
    
    var roomName: String = String()
    var roomBudget: Int!
    var roomRunningTab: Int!
    var roomRemainingBudget: Int!
    var roomType: String = String()
    
    var materialCount = 0
    var serviceCount = 0
    
    var roomProject: Project!
    var roomProjectID: String!
    var roomExpenses: [Expense] = []
    var roomExpensesID: [String] = []
    
    
    struct roomKeys {
        static let id = "roomID"
        static let name = "roomName"
        static let budget = "roomBudget"
        static let type = "roomType"
        static let project = "roomParent"
        static let expenses = "roomExpenses"
        static let tab = "roomRunningTab"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        
        if let roomIDObj = aDecoder.decodeObject(forKey: roomKeys.id) as? String { roomIdentifier = String(roomIDObj) }
        if let roomNameObj = aDecoder.decodeObject(forKey: roomKeys.name) as? String { roomName = String(roomNameObj) }
        if let roomBudgetObj = aDecoder.decodeObject(forKey: roomKeys.budget) as? Int { roomBudget = Int(roomBudgetObj)
        }
        if let roomTabObj = aDecoder.decodeObject(forKey: roomKeys.tab) as? Int { roomRunningTab = roomTabObj }
        if let roomTypeObj = aDecoder.decodeObject(forKey: roomKeys.type) as? String { roomType = String(roomTypeObj) }
        if let roomProjectObj = aDecoder.decodeObject(forKey: roomKeys.project) as? String { roomProjectID = roomProjectObj }
        if let expensesObj = aDecoder.decodeObject(forKey: roomKeys.expenses) as? [String] { roomExpensesID = expensesObj }
        
        roomRemainingBudget = roomBudget - roomRunningTab
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(roomIdentifier, forKey: roomKeys.id)
        aCoder.encode(roomName, forKey: roomKeys.name)
        aCoder.encode(roomBudget, forKey: roomKeys.budget)
        aCoder.encode(roomRunningTab, forKey: roomKeys.tab)
        aCoder.encode(roomType, forKey: roomKeys.type)
        aCoder.encode(roomProjectID, forKey: roomKeys.project)
        aCoder.encode(roomExpensesID, forKey: roomKeys.expenses)
    }
    
    func loadInExpenses() {
        
        roomExpenses = userData.loadInExpenses(forExpenseIDs: roomExpensesID)
        
        calcValues()
        
    }
    
    
    init(name: String, budget: String, type: String, project: Project) {
        super.init()
        
        roomIdentifier = UUID().uuidString
        
        roomName = name
        
        var budgetInt = budget.replacingOccurrences(of: "$", with: "")
        budgetInt = budgetInt.replacingOccurrences(of: ",", with: "")
        
        if let setBudget = Int(budgetInt) {
            print(setBudget)
            roomBudget = setBudget; roomRemainingBudget = setBudget
            print("roomBudget set to \(roomBudget)")
        } else {
            print("Problem converting value to int")
            roomBudget = 0; roomRemainingBudget = 0
        }
        
        roomRunningTab = 0
        
        roomProject = project
        roomProjectID = project.projectIdentifier
    }
    
    func addExpense(_ expense: Expense) {
        roomExpenses.insert(expense, at: 0)
        roomExpensesID.insert(expense.identifier, at: 0)
        userData.saveRoom(self)
        
        if expense is Service { serviceCount += 1 }
        else { materialCount += 1 }
        
        calcValues()
    }
    
    func removeExpense(_ expense: Expense) {
        roomExpenses.remove(at: roomExpenses.index(where: { $0.identifier == expense.identifier} )!)
        roomExpensesID.remove(at: roomExpensesID.index(of: expense.identifier)!)
        if expense is Service { serviceCount -= 1 }
        else { materialCount -= 1 }
        calcValues()
    }
    
    func setType(_ type: String) {
        roomType = type
        //appData.addToUserRooms(type)
    }
    
    func getRoomBudget() -> String {
        return UserData.formatDollars(roomBudget)
    }
    
    func getRoomTab() -> String {
        return UserData.formatDollars(roomRunningTab)
    }
    
    func getRoomRemaining() -> String {
        return UserData.formatDollars(roomRemainingBudget)
    }
    
    func getExpenseCount() -> Int {
        return roomExpenses.count
    }
    
    func getMaterialCount() -> Int {
        var count = 0
        for ex in roomExpenses {
            if ex is Material {
                count += 1
            }
        }
        return count
    }
    
    func getServiceCount() -> Int {
        var count = 0
        for ex in roomExpenses {
            if ex is Service {
                count += 1
            }
        }
        return count
    }
    
    func calcValues() {
        
        var runTab: Int {
            var total = 0.0
            for e in roomExpensesID {
                total += userData.loadInSingleExpense(id: e).totalCost
            }
            return Int(total)
        }
        
        roomRunningTab = Int(runTab)
        
        roomRemainingBudget = roomBudget - roomRunningTab
        
        //roomProject.calcValues()
        
    }
    
    static func == (lhs: Room,rhs: Room) -> Bool {
        return lhs.roomIdentifier == rhs.roomIdentifier
    }
    
}
