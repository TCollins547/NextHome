//
//  NewProjectCreationView.swift
//  Next Home
//
//  Created by Tyler Collins on 1/24/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class NewProjectCreationView: UIView {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectAddressTextField: UITextField!
    @IBOutlet weak var projectBudgetTextField: UITextField!
    @IBOutlet weak var expectedValueTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var addImageButton: UIButton!
    
    
    func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func addProjectButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.removeFromSuperview()
        
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
