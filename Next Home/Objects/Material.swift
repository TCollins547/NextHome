//
//  Material.swift
//  Next Home
//
//  Created by Tyler Collins on 2/10/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation

class Material: NSObject, NSCoding {
    
    var materialIdentifier: String!
    
    var materialName: String!
    var materialCost = 0
    
    init(name: String, matCost: String) {
        materialIdentifier = UUID().uuidString
        materialName = name
        materialCost = Int(matCost)!
    }
    
    struct Keys {
        static let id = "materialID"
        static let name = "materialName"
        static let cost = "materialCost"
    }
    
    required init(coder aDecoder: NSCoder) {
        if let materialIDObj = aDecoder.decodeObject(forKey: Keys.id) as? String { materialIdentifier = String(materialIDObj) }
        if let materialNameObj = aDecoder.decodeObject(forKey: Keys.name) as? String { materialName = String(materialNameObj) }
        if let materialCostObj = aDecoder.decodeObject(forKey: Keys.cost) as? Int { materialCost = Int(materialCostObj) }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(materialIdentifier, forKey: Keys.id)
        aCoder.encode(materialName, forKey: Keys.name)
        aCoder.encode(materialCost, forKey: Keys.cost)
    }
    
    static func == (lhs: Material,rhs: Material) -> Bool {
        return lhs.materialIdentifier == rhs.materialIdentifier
    }
    
}
