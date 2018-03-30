//
//  UserAppData.swift
//  Next Home
//
//  Created by Tyler Collins on 2/9/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit


class UserData {
    
    let IDDefaults = UserDefaults.standard
    
    var projects: [Project] = []
    var projectIDs: [String] = []
    
    var rooms: [Room] = []
    var roomIDs: [String] = []
    
    var roomTypes: [String] = []
    
    var expenses: [Expense] = []
    var expenseIDs: [String] = []
    
    struct Keys {
        static let projectIDKey = "projectIDs"
        static let roomIDKey = "roomIDs"
        static let expenseIDKey = "expenseIDs"
    }
    
    init() {
        roomTypes = ["Bathroom", "Bedroom", "Kitchen", "Dining Room", "Living Room", "Office", "Den", "Media Room", "Master Bathroom", "Master Bedroom", "Powder Room", "Laundry Room", "Garage", "Backyard", "Frontyard", "Dog Run"]
    }
    
    
    func getFilePath(identifier: String) -> String {
        var FilePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url?.appendingPathComponent(identifier).path)!
        }
        
        return FilePath
    }
    
    
    /*
     ——————————————— Expense Handling ———————————————
     Contains: saveExpense(Expense), deleteExpense(Expense)
    */
    
    func loadInExpenses(forExpenseIDs: [String]) -> [Expense] {
        
        var roomExpenses: [Expense] = []
        
        for expenseID in forExpenseIDs {
            
            let expenseFilePath = getFilePath(identifier: expenseID)
            
            if let readExpense = NSKeyedUnarchiver.unarchiveObject(withFile: expenseFilePath) as? Expense {
                roomExpenses.append(readExpense)
            }
            
        }
        
        return roomExpenses
        
    }
    
    func loadInSingleExpense(id: String) -> Expense {
        let expenseFilePath = getFilePath(identifier: id)
        let readExpense = NSKeyedUnarchiver.unarchiveObject(withFile: expenseFilePath) as? Expense
        return readExpense!
    }
    
    
    func saveExpense(_ newExpense: Expense) {
        expenses.insert(newExpense, at: 0)
        expenseIDs.insert(newExpense.identifier, at: 0)
        
        let expenseFilePath = getFilePath(identifier: newExpense.identifier)
        
        NSKeyedArchiver.archiveRootObject(newExpense, toFile: expenseFilePath)
        IDDefaults.set(expenseIDs, forKey: Keys.expenseIDKey)
        IDDefaults.synchronize()
        
    }
    
    
    func deleteExpense(_ deleteExpense: Expense) {
        guard expenses.contains(deleteExpense) else { return }
        expenseIDs.remove(at: expenseIDs.index(of: deleteExpense.identifier)!)
        expenses.remove(at: expenses.index(where: { $0.identifier == deleteExpense.identifier} )!)
        
        let expenseFilePath = getFilePath(identifier: deleteExpense.identifier)
        
        do {
            try FileManager.default.removeItem(atPath: expenseFilePath)
        } catch {
            //Handle Error
        }
        
        IDDefaults.set(expenseIDs, forKey: Keys.expenseIDKey)
        IDDefaults.synchronize()
    }
    
    
    
    
    
    /*
     ——————————————— Room Handling ———————————————
     Contains: saveRoom(Room), deleteRoom(Room), loadInRooms([String]) -> [Room], loadInAllRooms()
    */
    
    
    func saveRoom(_ newRoom: Room) {
        
        newRoom.calcValues()
        
        rooms.insert(newRoom, at: 0)
        roomIDs.insert(newRoom.roomIdentifier, at: 0)
        
        let roomFilePath = getFilePath(identifier: newRoom.roomIdentifier)
        
        NSKeyedArchiver.archiveRootObject(newRoom, toFile: roomFilePath)
        IDDefaults.set(roomIDs, forKey: Keys.roomIDKey)
        IDDefaults.synchronize()
        
    }
    
    func deleteRoom(_ deletedRoom: Room) {
        guard rooms.contains(deletedRoom) else { return }
        roomIDs.remove(at: roomIDs.index(of: deletedRoom.roomIdentifier)!)
        rooms.remove(at: rooms.index(where: { $0.roomIdentifier == deletedRoom.roomIdentifier} )!)
        
        for exp in deletedRoom.roomExpenses {
            userData.deleteExpense(exp)
        }
        
        
        let roomFilePath = getFilePath(identifier: deletedRoom.roomIdentifier)
        
        do {
            try FileManager.default.removeItem(atPath: roomFilePath)
        } catch {
            //Handle Error
        }
        
        IDDefaults.set(roomIDs, forKey: Keys.roomIDKey)
        IDDefaults.synchronize()
        
    }
    
    func loadInRooms(forRoomIDs: [String]) -> [Room] {
        
        var projectRooms: [Room] = []
        
        for roomID in forRoomIDs {
            
            let roomFilePath = getFilePath(identifier: roomID)
            
            if let readRoom = NSKeyedUnarchiver.unarchiveObject(withFile: roomFilePath) as? Room {
                readRoom.calcValues()
                projectRooms.append(readRoom)
            }
            
        }
        
        return projectRooms
        
    }
    
    func loadInSingleRoom(id: String) -> Room {
        print(id)
        let roomFilePath = getFilePath(identifier: id)
        let readRoom = NSKeyedUnarchiver.unarchiveObject(withFile: roomFilePath) as? Room
        readRoom?.calcValues()
        return readRoom!
        
    }
    
    func loadInAllRooms() {
        
        guard let readInIDs = IDDefaults.stringArray(forKey: Keys.roomIDKey) else { print("No room data"); return}
        
        roomIDs = readInIDs
        
        for roomID in roomIDs {
            
            let roomFilePath = getFilePath(identifier: roomID)
            
            if let readRoom = NSKeyedUnarchiver.unarchiveObject(withFile: roomFilePath) as? Room {
                readRoom.calcValues()
                rooms.append(readRoom)
            }
            
        }
        
    }
    
    
    
    /*
     ——————————————— Project Handling ———————————————
     Contains: saveProject(Project), deleteProject(Project), loadInProjects()
     */
    
    
    func saveProject(_ newProject: Project) {
        
        newProject.calcValues()
        
        if !projects.contains(newProject) {
            projects.insert(newProject, at: 0)
            projectIDs.insert(newProject.projectIdentifier, at: 0)
        }
        
        let projectFilePath = getFilePath(identifier: newProject.projectIdentifier)
        
        NSKeyedArchiver.archiveRootObject(newProject, toFile: projectFilePath)
        IDDefaults.set(projectIDs, forKey: Keys.projectIDKey)
        IDDefaults.synchronize()
    }
    
    func deleteProject(_ deletedProject: Project) {
        guard projects.contains(deletedProject) else { return }
        projectIDs.remove(at: projectIDs.index(of: deletedProject.projectIdentifier)!)
        
        for room in deletedProject.rooms {
            userData.deleteRoom(room)
        }
        
        
        let projectFilePath = getFilePath(identifier: deletedProject.projectIdentifier)
        
        
        
        projects.remove(at: projects.index(where: { $0.projectIdentifier == deletedProject.projectIdentifier} )!)
        do {
            try FileManager.default.removeItem(atPath: projectFilePath)
        } catch {
            //Handle removal error
        }
        
        IDDefaults.set(projectIDs, forKey: Keys.projectIDKey)
        IDDefaults.synchronize()
        
    }
    
    func loadInProjects() {
        
        guard let readInIDs = IDDefaults.stringArray(forKey: Keys.projectIDKey) else { print("No project data"); return }
        
        projectIDs = readInIDs
        
        for proID in projectIDs {
            
            let projectFilePath = getFilePath(identifier: proID)
            
            if let readProject = NSKeyedUnarchiver.unarchiveObject(withFile: projectFilePath) as? Project {
                readProject.calcValues()
                projects.append(readProject)
            }
        }
        
    }
    
    
    /*
     ——————————————— System-wide Functions ———————————————
     Contains: formatNumbersToDollars(String) -> String
    */
    
    static func formatDollars(_ stringValue: String) -> String {
        let textFieldValue = stringValue.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "$", with: "")
        
        guard let num = Double(textFieldValue) else {
            return "$"
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return "$" + numberFormatter.string(from: NSNumber(value: num))!
    }
    
    static func formatDollars(_ numValue: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return "$" + numberFormatter.string(from: NSNumber(value: numValue))!
    }
    
    static func formatDollars(_ numValue: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return "$" + formatter.string(from: NSNumber(value: numValue))!
    }
    
}
