//
//  Service.swift
//  Next Home
//
//  Created by Tyler Collins on 3/2/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import Foundation
import UIKit

class Service: Expense {
    
    var serviceProvider: String!
    var contactNumber: String!
    var contactEmail: String!
    
    //var payments: [String: Double]!
    
    init(inputName: String, inputType: String, cost: Double, provider: String) {
        super.init(inputName: inputName, inputType: inputType, cost: cost)
        
        serviceProvider = provider
    }
    
    func updateInfo(inputName: String, inputType: String, cost: Double, provider: String) {
        super.updateInfo(inputName: inputName, inputType: inputType, cost: cost)
        
        serviceProvider = provider
    }
    
    /*
    func addPayment(label: String, cost: Double) {
        payments[label] = cost
    }
    
    func removePayment(_ label: String) {
        payments.removeValue(forKey: label)
    }
 */
 
    func setContactNumber(_ number: String) {
        contactNumber = number
    }
    
    func setContactEmail(_ email: String) {
        contactEmail = email
    }
    
    struct Keys {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }
    
}
