//
//  Project.swift
//  Next Home
//
//  Created by Tyler Collins on 1/23/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Project {
    
    var projectName: String
    var projectAddress: String
    var projectRunningTab: String
    var projectImage: UIImage
    
    var projectIdentifier: Int!
    
    init(id: Int, name: String, address: String, tab: String, image: UIImage) {
        
        projectIdentifier = id
        
        projectName = name
        projectAddress = address
        projectRunningTab = tab
        projectImage = image
    }
    
}
