//
//  Project.swift
//  Next Home
//
//  Created by Tyler Collins on 1/23/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Project: Equatable {
    
    var projectName: String
    var projectAddress: String
    var projectRunningTab = "0"
    var projectBudget = "0"
    var projectStartDate: String
    var projectHomeImage: UIImage
    
    var projectRemainingBudget = "N/A"
    var projectExpectedValue = "N/A"
    var projectExpectedEndDate = "N/A"
    
    var rooms: [String:[Room]] = [:]
    
    var projectImages: [UIImage] = []
    
    var projectIdentifier: String!
    
    init(name: String, address: String, budget: String, startDate: String, image: UIImage) {
        
        projectIdentifier = UUID().uuidString
        
        projectName = name
        projectAddress = address
        projectBudget = "0"
        projectStartDate = startDate
        
        projectHomeImage = image
        addProjectImage(addedImage: image)
        
        projectRunningTab = formatNumbers(number: "0")
        projectRemainingBudget = formatNumbers(number: budget)
        projectBudget = formatNumbers(number: budget)
        
    }
    
    func addRoom(newRoom: Room, section: String) {
        if rooms[section] == nil {
            rooms[section] = [newRoom]
        } else {
            rooms[section]?.append(newRoom)
        }
        
        UserAppData.userItems.userRooms.insert(newRoom, at: 0)
        
    }
    
    func addProjectImage(addedImage: UIImage) {
        projectImages.insert(addedImage, at: 0)
    }
    
    func removeProjectImage(removedImage: UIImage) {
        for image in projectImages {
            if removedImage == image {
                projectImages.remove(at: projectImages.index(of: image)!)
            }
        }
    }
    
    func getProjectImages() -> [UIImage] {
        return projectImages
    }
    
    func setExpectedValue(ev: String) {
        projectExpectedValue = formatNumbers(number: ev)
        
    }
    
    func setExpectedEndDate(ed: String) {
        projectExpectedEndDate = ed
    }
    
    
    func formatNumbers(number: String) -> String {
        let num = Int(number)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return numberFormatter.string(from: NSNumber(value:num!))!
    }
    
    static func == (lhs: Project,rhs: Project) -> Bool {
        return lhs.projectIdentifier == rhs.projectIdentifier
    }
    
}
