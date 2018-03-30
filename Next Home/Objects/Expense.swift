//
//  Expense.swift
//  Next Home
//
//  Created by Tyler Collins on 3/2/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Expense: NSObject, NSCoding {
    
    var identifier: String!
    
    var name: String!
    var type: String!
    var totalCost: Double!
    var note: String!
    //var expenseImage: UIImage!
    
    init(inputName: String, inputType: String, cost: Double) {
        super.init()
        name = inputName
        type = inputType
        //appData.addToUserExpenses(inputType)
        totalCost = cost
        identifier = UUID().uuidString
    }
    
    func updateInfo(inputName: String, inputType: String, cost: Double) {
        name = inputName
        type = inputType
        //appData.addToUserExpenses(inputType)
        totalCost = cost
    }
    
    func setNote(_ input: String) {
        note = input
    }
    
    func getDisplayCost() -> String {
        return UserData.formatDollars(totalCost)
    }
    
    struct expenseKeys {
        static let id = "expenseID"
        static let name = "expenseName"
        static let type = "expenseType"
        static let totalCost = "expenseTotalCost"
        static let note = "expenseNote"
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let idObj = aDecoder.decodeObject(forKey: expenseKeys.id) as? String { identifier = idObj }
        if let nameObj = aDecoder.decodeObject(forKey: expenseKeys.name) as? String { name = nameObj }
        if let typeObj = aDecoder.decodeObject(forKey: expenseKeys.type) as? String { type = typeObj }
        if let totCostObj = aDecoder.decodeObject(forKey: expenseKeys.totalCost) as? Double { totalCost = totCostObj }
        if let noteObj = aDecoder.decodeObject(forKey: expenseKeys.note) as? String { note = noteObj }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(identifier, forKey: expenseKeys.id)
        aCoder.encode(name, forKey: expenseKeys.name)
        aCoder.encode(type, forKey: expenseKeys.type)
        aCoder.encode(totalCost, forKey: expenseKeys.totalCost)
        aCoder.encode(note, forKey: expenseKeys.note)
    }
    
    
}
