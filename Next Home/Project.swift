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
    var projectRunningTab: String
    var projectBudget: String
    var projectImage: UIImage
    
    var projectIdentifier: String!
    
    init(id: String, name: String, address: String, budget: String, image: UIImage) {
        
        projectIdentifier = id
        
        projectName = name
        projectAddress = address
        projectBudget = budget
        projectImage = image
        projectRunningTab = "0"
        
        formatNumbers()
        
    }
    
    
    func formatNumbers() {
        let budget = Int(projectBudget)
        let tab = Int(projectRunningTab)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        projectBudget = numberFormatter.string(from: NSNumber(value:budget!))!
        projectRunningTab = numberFormatter.string(from: NSNumber(value:tab!))!
    }
    
}
