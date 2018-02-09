//
//  Project.swift
//  Next Home
//
//  Created by Tyler Collins on 1/23/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

struct userCreatedProjects {
    var userProjects = [Project]()
}

class Project {
    
    var projectName: String
    var projectAddress: String
    var projectRunningTab = "0"
    var projectBudget = "0"
    var projectStartDate: String
    var projectHomeImage: UIImage
    
    var projectRemainingBudget = "N/A"
    var projectExpectedValue = "N/A"
    var projectExpectedEndDate = "N/A"
    
    var projectImages: [UIImage] = []
    
    var projectIdentifier: String!
    
    init(id: String, name: String, address: String, budget: String, startDate: String, image: UIImage) {
        
        projectIdentifier = id
        
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
    
    func addProjectImage(addedImage: UIImage) {
        projectImages.insert(addedImage, at: 0)
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
    
}
