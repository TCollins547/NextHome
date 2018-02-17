//
//  Material.swift
//  Next Home
//
//  Created by Tyler Collins on 2/10/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation

class Material: Equatable {
    
    var materialIdentifier: String!
    
    var materialName: String!
    
    init(name: String) {
        materialIdentifier = UUID().uuidString
        materialName = name
    }
    
    static func == (lhs: Material,rhs: Material) -> Bool {
        return lhs.materialIdentifier == rhs.materialIdentifier
    }
    
}
