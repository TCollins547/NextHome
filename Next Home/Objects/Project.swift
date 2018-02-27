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
    
    var projectRunningTab = 0
    var projectBudget: Int!
    var projectRemainingBudget = 0
    var projectExpectedValue = "N/A"
    var projectExpectedEndDate = "N/A"
    
    var rooms: [Room] = []
    
    var projectImages: [UIImage] = []
    
    var projectIdentifier: String!
    
    
    struct Keys {
        static let name = "projectName"
        static let address = "projectAddress"
        static let start = "projectStart"
        static let end = "projectEnd"
        static let image = "projectImage"
        static let value = "projectEV"
        static let budget = "projectBudget"
        static let rooms = "projectRooms"
        static let id = "projectID"
        static let allImages = "allProjectImages"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        if let projectNameObj = aDecoder.decodeObject(forKey: Keys.name) as? String { projectName = String(projectNameObj) }
        if let projectAddressObj = aDecoder.decodeObject(forKey: Keys.address) as? String { projectAddress = String(projectAddressObj) }
        if let projectStartObj = aDecoder.decodeObject(forKey: Keys.start) as? String { projectStartDate = String(projectStartObj) }
        if let projectEndObj = aDecoder.decodeObject(forKey: Keys.end) as? String { projectExpectedEndDate = String(projectEndObj) }
        if let projectImageObj = aDecoder.decodeObject(forKey: Keys.image) as? UIImage { projectHomeImage = projectImageObj }
        if let projectValueObj = aDecoder.decodeObject(forKey: Keys.value) as? String { projectExpectedValue = String(projectValueObj) }
        if let projectBudgetObj = aDecoder.decodeObject(forKey: Keys.budget) as? Int { projectBudget = Int(projectBudgetObj) }
        if let projectRooms = aDecoder.decodeObject(forKey: Keys.rooms) as? [Room] { rooms = projectRooms }
        if let projectIDObj = aDecoder.decodeObject(forKey: Keys.id) as? String { projectIdentifier = String(projectIDObj) }
        if let projectAllImagesObj = aDecoder.decodeObject(forKey: Keys.allImages) as? [UIImage] { projectImages = projectAllImagesObj }
        
        calcValues()
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(projectName, forKey: Keys.name)
        aCoder.encode(projectAddress, forKey: Keys.address)
        aCoder.encode(projectStartDate, forKey: Keys.start)
        aCoder.encode(projectExpectedEndDate, forKey: Keys.end)
        aCoder.encode(projectHomeImage, forKey: Keys.image)
        aCoder.encode(projectExpectedValue, forKey: Keys.value)
        aCoder.encode(projectBudget, forKey: Keys.budget)
        aCoder.encode(rooms, forKey: Keys.rooms)
        aCoder.encode(projectIdentifier, forKey: Keys.id)
        aCoder.encode(projectImages, forKey: Keys.allImages)
    }
    
    
    init(name: String, address: String, budget: String, startDate: String, image: UIImage) {
        super.init()
        projectIdentifier = UUID().uuidString
        
        projectName = name
        projectAddress = address
        projectStartDate = startDate
        
        projectHomeImage = image
        addProjectImage(addedImage: image)
        
        var budgetInt = budget.replacingOccurrences(of: "$", with: "")
        budgetInt = budgetInt.replacingOccurrences(of: ",", with: "")
        
        projectRemainingBudget = Int(budgetInt)!
        projectBudget = Int(budgetInt)!
    }
    
    func updateValues(name: String, address: String, budget: String, startDate: String, image: UIImage) {
        projectName = name
        projectAddress = address
        projectStartDate = startDate
        
        projectHomeImage = image
        addProjectImage(addedImage: image)
        
        var budgetInt = budget.replacingOccurrences(of: "$", with: "")
        budgetInt = budgetInt.replacingOccurrences(of: ",", with: "")
        
        projectRemainingBudget = Int(budgetInt)!
        projectBudget = Int(budgetInt)!
        
        appData.saveData(self)
        
    }
    
    func calcValues() {
        
        var total = 0
        for room in rooms {
            total += room.roomRunningTab
        }
        
        projectRunningTab = total
        
        projectRemainingBudget = projectBudget - projectRunningTab
        
    }
    
    func addRoom(newRoom: Room) {
        rooms.append(newRoom)
        appData.addToList(newRoom)
        appData.saveData(self)
    }
    
    func addProjectImage(addedImage: UIImage) {
        projectImages.insert(addedImage, at: 0)
        appData.saveData(self)
    }
    
    func removeProjectImage(removedImage: UIImage) {
        for image in projectImages {
            if removedImage == image {
                projectImages.remove(at: projectImages.index(of: image)!)
                appData.saveData(self)
            }
        }
    }
    
    func getBudget() -> String {
        return formatNumbers(number: String(self.projectBudget))
    }
    
    func setBudget(_ value: String) {
        var intValue = value.replacingOccurrences(of: "$", with: "")
        intValue = intValue.replacingOccurrences(of: ",", with: "")
        projectBudget = Int(intValue)!
    }
    
    func getRemainingBudget() -> String {
        return formatNumbers(number: String(self.projectRemainingBudget))
    }
    
    func getRunningTab() -> String {
        return formatNumbers(number: String(self.projectRunningTab))
    }
    
    func getProjectImages() -> [UIImage] {
        return projectImages
    }
    
    func setExpectedValue(ev: String) {
        projectExpectedValue = ev
        appData.saveData(self)
    }
    
    func setExpectedEndDate(ed: String) {
        projectExpectedEndDate = ed
        appData.saveData(self)
    }
    
    
    func formatNumbers(number: String) -> String {
        let num = Int(number)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return "$" + numberFormatter.string(from: NSNumber(value:num!))!
    }
    
    static func == (lhs: Project,rhs: Project) -> Bool {
        return lhs.projectIdentifier == rhs.projectIdentifier
    }
    
}
