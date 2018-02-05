//
//  NewProjectCreationView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/3/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class NewProjectCreationView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var projectTitleTextField: UITextField!
    @IBOutlet weak var projectAddressTextField: UITextField!
    @IBOutlet weak var projectBudgetTextField: UITextField!
    @IBOutlet weak var expectValueTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var projectImage: UIButton!
    
    var activeTextField: UITextField!
    
    var parentView: MainViewController!
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        setupDatePicker()
    }
    
    func connectParentView(connectView: MainViewController) {
        parentView = connectView
    }
    
    func setupDatePicker() {
        
        activeTextField = projectTitleTextField
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(NewProjectCreationView.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        
    }
    
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
    }
    
    @IBAction func addProjectButtonPressed(_ sender: Any) {
        
        var canAddProject = true
        
        if projectTitleTextField.text == "" {
            canAddProject = false
            projectTitleTextField.backgroundColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
        if projectAddressTextField.text == "" {
            canAddProject = false
            projectAddressTextField.backgroundColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
        if projectBudgetTextField.text == "" {
            canAddProject = false
            projectBudgetTextField.backgroundColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
        if startDateTextField.text == "" {
            canAddProject = false
            startDateTextField.backgroundColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
//        if projectImage.currentBackgroundImage == #imageLiteral(resourceName: "AddImage") {
//            //projectTitleTextField.backgroundColor = UIColor.red
//        }
        
        if canAddProject {parentView.addProject()}
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        parentView.cancelProjectCreate()
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        activeTextField.text = formatter.string(from: sender.date)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField != startDateTextField && textField != endDateTextField {
            self.endEditing(true)
        }
        self.activeTextField = textField
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
