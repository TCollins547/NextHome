//
//  NewProjectCreationView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/3/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class NewProjectCreationView: UIView, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var projectTitleTextField: UITextField!
    @IBOutlet weak var projectAddressTextField: UITextField!
    @IBOutlet weak var projectBudgetTextField: UITextField!
    @IBOutlet weak var expectValueTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var projectImage: UIButton!
    
    var activeTextField: UITextField!
    
    var parentView: UIViewController!
    
    var viewProject: Project!
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        setupDatePicker()
    }
    
    func connectParentView(connectView: UIViewController) {
        if connectView is MainViewController {
            parentView = connectView as! MainViewController
        } else {
            parentView = connectView as! RoomViewController
        }
    }
    
    func fillProjectInfo(project: Project) {
        viewProject = project
        projectTitleTextField.text = project.projectName
        projectAddressTextField.text = project.projectAddress
        projectBudgetTextField.text = project.projectBudget.replacingOccurrences(of: ",", with: "")
        startDateTextField.text = project.projectStartDate
        projectImage.setBackgroundImage(project.projectHomeImage, for: .normal)
        
        if project.projectExpectedEndDate == "N/A" {
            endDateTextField.text = ""
        } else {
            endDateTextField.text = project.projectExpectedEndDate
        }
        
        if project.projectExpectedValue == "N/A" {
            endDateTextField.text = ""
        } else {
            expectValueTextField.text = project.projectExpectedValue.replacingOccurrences(of: ",", with: "")
        }
        
        
        
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
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        parentView.present(image, animated: true) {
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            projectImage.setBackgroundImage(image, for: UIControlState.normal)
        } else {
            //Write error message
        }
        
        parentView.dismiss(animated: true, completion: nil)
        
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
        if projectImage.currentBackgroundImage == #imageLiteral(resourceName: "AddImage") {
            canAddProject = false
            
            let image = #imageLiteral(resourceName: "AddImage").withRenderingMode(.alwaysTemplate)
            projectImage.setBackgroundImage(image, for: .normal)
            projectImage.tintColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
        
        if canAddProject {
            if parentView is MainViewController {
                createNewProject()
            } else {
                updateProject()
            }
            
        }
        
    }
    
    func createNewProject() {
        let newProject = Project(id: UUID().uuidString, name: projectTitleTextField.text!, address: projectAddressTextField.text!, budget: projectBudgetTextField.text!, startDate: startDateTextField.text!, image: projectImage.currentBackgroundImage!)
        if expectValueTextField.text != "" {
            newProject.setExpectedValue(ev: expectValueTextField.text!)
        }
        if endDateTextField.text != "" {
            newProject.setExpectedEndDate(ed: endDateTextField.text!)
        }
        
        UserAppData.userItems.userProjects.insert(newProject, at: 0)
        cancelButtonPressed(self)
        (parentView as! MainViewController).tableView.reloadData()
    }
    
    func updateProject() {
        viewProject.projectName = projectTitleTextField.text!
        viewProject.projectAddress = projectAddressTextField.text!
        viewProject.projectBudget = viewProject.formatNumbers(number: projectBudgetTextField.text!)
        viewProject.projectStartDate = startDateTextField.text!
        
        if projectImage.currentBackgroundImage! != viewProject.projectHomeImage {
            viewProject.projectHomeImage = projectImage.currentBackgroundImage!
            viewProject.addProjectImage(addedImage: projectImage.currentBackgroundImage!)
        }
        
        if expectValueTextField.text != "" {
            print(expectValueTextField.text!)
            viewProject.setExpectedValue(ev: expectValueTextField.text!)
        }
        
        if endDateTextField.text != "" {
            print(endDateTextField.text!)
            viewProject.setExpectedEndDate(ed: endDateTextField.text!)
        }
        
        cancelButtonPressed(self)
        (parentView as! RoomViewController).refreshView()
        
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        if parentView is MainViewController {
            (parentView as! MainViewController).cancelProjectCreate()
        } else {
            (parentView as! RoomViewController).cancelProjectEdit()
        }
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
