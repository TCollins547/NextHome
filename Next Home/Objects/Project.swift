//
//  Project.swift
//  Next Home
//
//  Created by Tyler Collins on 1/23/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Project: NSObject, NSCoding {
    
    var projectName: String!
    var projectAddress: String!
    var projectStartDate: String!
    var projectHomeImage: UIImage!
    
    var projectRunningTab: Int!
    var projectBudget: Int!
    var projectRemainingBudget: Int!
    var projectExpectedValue = "N/A"
    var projectExpectedEndDate = "N/A"
    
    var rooms: [Room] = []
    var roomsID: [String] = []
    
    var projectImages: [UIImage] = []
    
    var projectIdentifier: String!
    
    
    struct projectKeys {
        static let name = "projectName"
        static let address = "projectAddress"
        static let start = "projectStart"
        static let end = "projectEnd"
        static let image = "projectImage"
        static let value = "projectEV"
        static let budget = "projectBudget"
        static let tab = "projectRunningtab"
        static let rooms = "projectRooms"
        static let id = "projectID"
        static let allImages = "allProjectImages"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let projectNameObj = aDecoder.decodeObject(forKey: projectKeys.name) as? String { projectName = String(projectNameObj) }
        if let projectAddressObj = aDecoder.decodeObject(forKey: projectKeys.address) as? String { projectAddress = String(projectAddressObj) }
        if let projectStartObj = aDecoder.decodeObject(forKey: projectKeys.start) as? String { projectStartDate = String(projectStartObj) }
        if let projectEndObj = aDecoder.decodeObject(forKey: projectKeys.end) as? String { projectExpectedEndDate = String(projectEndObj) }
        if let projectImageObj = aDecoder.decodeObject(forKey: projectKeys.image) as? UIImage { projectHomeImage = projectImageObj }
        if let projectValueObj = aDecoder.decodeObject(forKey: projectKeys.value) as? String { projectExpectedValue = String(projectValueObj) }
        if let projectBudgetObj = aDecoder.decodeObject(forKey: projectKeys.budget) as? Int { projectBudget = Int(projectBudgetObj) }
        if let projectTabObj = aDecoder.decodeObject(forKey: projectKeys.tab) as? Int { projectRunningTab = projectTabObj }
        if let projectRooms = aDecoder.decodeObject(forKey: projectKeys.rooms) as? [String] { roomsID = projectRooms }
        if let projectIDObj = aDecoder.decodeObject(forKey: projectKeys.id) as? String { projectIdentifier = String(projectIDObj) }
        if let projectAllImagesObj = aDecoder.decodeObject(forKey: projectKeys.allImages) as? [UIImage] { projectImages = projectAllImagesObj }
        
        projectRemainingBudget = projectBudget - projectRunningTab
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(projectName, forKey: projectKeys.name)
        aCoder.encode(projectAddress, forKey: projectKeys.address)
        aCoder.encode(projectStartDate, forKey: projectKeys.start)
        aCoder.encode(projectExpectedEndDate, forKey: projectKeys.end)
        aCoder.encode(projectHomeImage, forKey: projectKeys.image)
        aCoder.encode(projectExpectedValue, forKey: projectKeys.value)
        aCoder.encode(projectBudget, forKey: projectKeys.budget)
        aCoder.encode(projectRunningTab, forKey: projectKeys.tab)
        aCoder.encode(roomsID, forKey: projectKeys.rooms)
        aCoder.encode(projectIdentifier, forKey: projectKeys.id)
        aCoder.encode(projectImages, forKey: projectKeys.allImages)
    }
    
    
    init(name: String, address: String, budget: String, startDate: String, image: UIImage) {
        super.init()
        projectIdentifier = UUID().uuidString
        print("Here")
        projectName = name
        projectAddress = address
        projectStartDate = startDate
        
        projectHomeImage = image
        projectImages.insert(image, at: 0)
        
        var budgetInt = budget.replacingOccurrences(of: "$", with: "")
        budgetInt = budgetInt.replacingOccurrences(of: ",", with: "")
        
        if let setBudget = Int(budgetInt) {
            print(setBudget)
            projectBudget = setBudget; projectRemainingBudget = setBudget
            print("roomBudget set to \(projectBudget)")
        } else {
            print("Problem converting value to int")
            projectBudget = 0; projectRemainingBudget = 0
        }
        
        projectRunningTab = 0
    }
    
    func loadInRooms() {
        
        rooms = userData.loadInRooms(forRoomIDs: roomsID)
        
        calcValues()
        
    }
    
    func updateValues(name: String, address: String, budget: String, startDate: String, image: UIImage) {
        projectName = name
        projectAddress = address
        projectStartDate = startDate
        
        if image != projectHomeImage {
            projectHomeImage = image
            addProjectImage(addedImage: image)
        }
        
        var budgetInt = budget.replacingOccurrences(of: "$", with: "")
        budgetInt = budgetInt.replacingOccurrences(of: ",", with: "")
        
        projectRemainingBudget = Int(budgetInt)!
        projectBudget = Int(budgetInt)!
        
        userData.saveProject(self)
        
    }
    
    func calcValues() {
        
        var runTab: Int {
            var total = 0
            for r in roomsID {
                total += userData.loadInSingleRoom(id: r).roomRunningTab
            }
            return total
        }
        
        projectRunningTab = runTab
        
        projectRemainingBudget = projectBudget - projectRunningTab
        
    }
    
    func addRoom(newRoom: Room) {
        rooms.append(newRoom)
        roomsID.append(newRoom.roomIdentifier)
        calcValues()
        userData.saveProject(self)
    }
    
    func removeRoom(_ removedRoom: Room) {
        rooms.remove(at: rooms.index(where: { $0.roomIdentifier == removedRoom.roomIdentifier} )!)
        roomsID.remove(at: roomsID.index(of: removedRoom.roomIdentifier)!)
        userData.deleteRoom(removedRoom)
        calcValues()
        userData.saveProject(self)
    }
    
    func addProjectImage(addedImage: UIImage) {
        projectImages.insert(addedImage, at: 0)
        userData.saveProject(self)
    }
    
    func removeProjectImage(removedImage: UIImage) {
        for image in projectImages {
            if removedImage == image {
                projectImages.remove(at: projectImages.index(of: image)!)
                userData.saveProject(self)
            }
        }
    }
    
    func getBudget() -> String {
        return UserData.formatDollars(projectBudget)
    }
    
    func setBudget(_ value: String) {
        var intValue = value.replacingOccurrences(of: "$", with: "")
        intValue = intValue.replacingOccurrences(of: ",", with: "")
        projectBudget = Int(intValue)!
    }
    
    func getRemainingBudget() -> String {
        return UserData.formatDollars(projectBudget - projectRunningTab)
    }
    
    func getRunningTab() -> String {
        return UserData.formatDollars(projectRunningTab)
    }
    
    func getProjectImages() -> [UIImage] {
        return projectImages
    }
    
    func setExpectedValue(ev: String) {
        projectExpectedValue = ev
        userData.saveProject(self)
    }
    
    func setExpectedEndDate(ed: String) {
        projectExpectedEndDate = ed
        userData.saveProject(self)
    }
    
    
    func formatNumbersToDollars(number: String) -> String {
        let num = Int(number)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return "$" + numberFormatter.string(from: NSNumber(value:num!))!
    }
    
    static func == (lhs: Project,rhs: Project) -> Bool {
        return lhs.projectIdentifier == rhs.projectIdentifier
    }
    
}
