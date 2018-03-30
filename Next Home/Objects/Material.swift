//
//  Material.swift
//  Next Home
//
//  Created by Tyler Collins on 2/10/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Material: Expense {
    
    var boughtFromStoreName: String!
    var boughtFromStoreAddress: String!
    var boughtFromWebsite: String!
    var boughtFromPhone: String!
    
    var unit: String!
    var unitCost: Double!
    var unitsBought: Double!
    var unitsUsed: Double!
    
    var expenseImage: UIImage!
    var reciptImage: UIImage!
    
    init(iName: String, iType: String, tCost: Double, uType: String, uCost: Double, materialImage: UIImage) {
        
        super.init(inputName: iName, inputType: iType, cost: tCost)
        
        expenseImage = materialImage
        unit = uType
        unitCost = uCost
        
        boughtFromStoreName = "Store Name N/A"
        boughtFromStoreAddress = "Store Address N/A"
        boughtFromPhone = "N/A"
        boughtFromWebsite = "N/A"
        
    }
    
    func updateInfo(iName: String, iType: String, tCost: Double, uType: String, uCost: Double, materialImage: UIImage) {
        super.updateInfo(inputName: iName, inputType: iType, cost: tCost)
        
        expenseImage = materialImage
        unit = uType
        unitCost = uCost
    }
    
    func getDisplayUnitCost() -> String {
        return UserData.formatDollars(unitCost)
    }
    
    func setBought(_ uBought: Double) {
        unitsBought = uBought
    }
    
    func setUsed(_ uUsed: Double) {
        unitsUsed = uUsed
    }
    
    func setStore(_ storeName: String, _ storeAddress: String) {
        boughtFromStoreName = storeName
        boughtFromStoreAddress = storeAddress
    }
    
    func setWebsite(_ site: String) {
        boughtFromWebsite = site
    }
    
    func setPhone(_ num: String) {
        boughtFromPhone = num
    }
    
    func setReciptImage(_ reciptImg: UIImage) {
        reciptImage = reciptImg
    }
    
    struct materialKeys {
        static let storeName = "storeName"
        static let storeAdd = "storeAddress"
        static let phoneNum = "phoneNumber"
        static let website = "website"
        
        static let unit = "unit"
        static let unitCost = "unitCost"
        static let unitBought = "unitBought"
        static let unitUsed = "unitUsed"
        
        static let productImage = "materialImage"
        static let reciptImage = "reciptImage"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let storeNameObj = aDecoder.decodeObject(forKey: materialKeys.storeName) as? String { boughtFromStoreName = storeNameObj }
        if let storeAddObj = aDecoder.decodeObject(forKey: materialKeys.storeAdd) as? String { boughtFromStoreAddress = storeAddObj }
        if let phoneObj = aDecoder.decodeObject(forKey: materialKeys.phoneNum) as? String { boughtFromPhone = phoneObj }
        if let webObj = aDecoder.decodeObject(forKey: materialKeys.website) as? String { boughtFromWebsite = webObj }
        
        if let unitObj = aDecoder.decodeObject(forKey: materialKeys.unit) as? String { unit = unitObj }
        if let unitCostObj = aDecoder.decodeObject(forKey: materialKeys.unitCost) as? Double { unitCost = unitCostObj }
        if let unitBoughtObj = aDecoder.decodeObject(forKey: materialKeys.unitBought) as? Double { unitsBought = unitBoughtObj }
        if let unitUsedObj = aDecoder.decodeObject(forKey: materialKeys.unitUsed) as? Double { unitsUsed = unitUsedObj }
        
        if let proImgObj = aDecoder.decodeObject(forKey: materialKeys.productImage) as? UIImage { expenseImage = proImgObj }
        if let recImgObj = aDecoder.decodeObject(forKey: materialKeys.reciptImage) as? UIImage { reciptImage = recImgObj }
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        
        aCoder.encode(boughtFromStoreName, forKey: materialKeys.storeName)
        aCoder.encode(boughtFromStoreAddress, forKey: materialKeys.storeAdd)
        aCoder.encode(boughtFromPhone, forKey: materialKeys.phoneNum)
        aCoder.encode(boughtFromWebsite, forKey: materialKeys.website)
        
        aCoder.encode(unit, forKey: materialKeys.unit)
        aCoder.encode(unitCost, forKey: materialKeys.unitCost)
        aCoder.encode(unitsBought, forKey: materialKeys.unitBought)
        aCoder.encode(unitsUsed, forKey: materialKeys.unitUsed)
        
        aCoder.encode(expenseImage, forKey: materialKeys.productImage)
        aCoder.encode(reciptImage, forKey: materialKeys.reciptImage)
        
    }
    
    static func == (lhs: Material,rhs: Material) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
