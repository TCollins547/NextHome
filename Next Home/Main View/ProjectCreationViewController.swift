//
//  ProjectCreationViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 2/25/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ProjectCreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var fullContentView: UIView!
    @IBOutlet weak var optionalContentView: UIView!
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectAddressTextField: UITextField!
    @IBOutlet weak var projectBudgetTextField: UITextField!
    @IBOutlet weak var projectStartDateTextField: UITextField!
    @IBOutlet weak var projectExpectedValueTextField: UITextField!
    @IBOutlet weak var projectEndDateTextField: UITextField!
    
    var activeTextField: UITextField!
    
    @IBOutlet weak var addProjectButton: UIButton!
    @IBOutlet weak var deleteProjectButton: UIButton!
    @IBOutlet weak var markCompleteButton: UIButton!
    
    var viewProject: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullContentView.layer.cornerRadius = 8
        optionalContentView.layer.cornerRadius = 8
        
        if viewProject != nil {
            fillViewInfo()
        }
        
        setupDatePicker()
        setupKeyboard()
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fillViewInfo() {
        
        addImageButton.setBackgroundImage(viewProject.projectHomeImage, for: .normal)
        projectNameTextField.text = viewProject.projectName
        projectAddressTextField.text = viewProject.projectAddress
        projectStartDateTextField.text = viewProject.projectStartDate
        projectBudgetTextField.text = viewProject.getBudget()
        
        if viewProject.projectExpectedValue != "N/A" {
            projectExpectedValueTextField.text = viewProject.projectExpectedValue
        }
        
        if viewProject.projectExpectedEndDate != "N/A" {
            projectEndDateTextField.text = viewProject.projectExpectedEndDate
        }
        
        addProjectButton.setTitle("Save Changes", for: .normal)
        deleteProjectButton.isHidden = false
        markCompleteButton.isHidden = false
        
    }
    
    
    
    func setupDatePicker() {
        activeTextField = projectNameTextField
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(NewProjectCreationView.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(self.dismissButtonPressed))
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        projectStartDateTextField.inputAccessoryView = toolBar
        projectEndDateTextField.inputAccessoryView = toolBar
        
        projectStartDateTextField.delegate = self; projectStartDateTextField.inputView = datePicker
        projectEndDateTextField.delegate = self; projectEndDateTextField.inputView = datePicker
    }
    
    @objc func dismissButtonPressed() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        activeTextField.text = formatter.string(from: sender.date)
    }
    
    
    
    
    
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        projectBudgetTextField.delegate = self
        projectExpectedValueTextField.delegate = self
        projectBudgetTextField.addTarget(self, action: #selector(TextFieldChanged(textfield:)), for: UIControlEvents.editingChanged)
        projectExpectedValueTextField.addTarget(self, action: #selector(TextFieldChanged(textfield:)), for: UIControlEvents.editingChanged)
        
        
    }
    
    @objc func TextFieldChanged(textfield: UITextField) {
        
        var textFieldValue = textfield.text?.replacingOccurrences(of: ",", with: "")
        textFieldValue = textFieldValue?.replacingOccurrences(of: "$", with: "")
        
        guard let num = Int(textFieldValue!) else {
            textfield.text = "$"
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        textfield.text = "$" + numberFormatter.string(from: NSNumber(value: num))!
        
    }
    
    
    
    
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardDidChangeFrame {
            
            var originY = 0
            
            if activeTextField.superview == optionalContentView {
                originY = Int(self.optionalContentView.convert(activeTextField.frame, to: self.view).origin.y)
            } else {
                originY = Int(activeTextField.frame.origin.y)
            }
            
            if CGFloat(originY) + activeTextField.frame.height > self.view.frame.height - keyboardFrame.height - 40 {
                self.view.frame.origin.y = -keyboardFrame.height
            } else {
                self.view.frame.origin.y = 0
            }
        } else {
            self.view.frame.origin.y = 0
        }
        
    }
    
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            (addImageButton.subviews[0] as? UIImageView)?.contentMode = .scaleAspectFill
            addImageButton.setBackgroundImage(image, for: .normal)
        } else {
            //Write error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) { }
    }
    
    
    func checkFields() -> Bool {
        
        var canCreate = true
        
        if projectNameTextField.text == nil {
            canCreate = false
            projectNameTextField.backgroundColor = UIColor.red
        }
        
        if projectAddressTextField.text == nil {
            canCreate = false
            projectAddressTextField.backgroundColor = UIColor.red
        }
        
        if projectStartDateTextField.text == nil {
            canCreate = false
            projectStartDateTextField.backgroundColor = UIColor.red
        }
        
        if projectBudgetTextField.text == "$" {
            canCreate = false
            projectBudgetTextField.backgroundColor = UIColor.red
        }
        
        if addImageButton.currentBackgroundImage == #imageLiteral(resourceName: "AddImage") {
            canCreate = false
            addImageButton.backgroundColor = UIColor.red
        }
        
        return canCreate
    }
    
    @IBAction func addProjectButtonPressed(_ sender: Any) {
        
        if checkFields() && viewProject == nil {
            let newProject = Project(name: projectNameTextField.text!, address: projectAddressTextField.text!, budget: projectBudgetTextField.text!, startDate: projectStartDateTextField.text!, image: addImageButton.currentBackgroundImage!)
            if projectEndDateTextField.text != nil {
                newProject.setExpectedEndDate(ed: projectEndDateTextField.text!)
            }
            if projectExpectedValueTextField.text != nil {
                newProject.setExpectedValue(ev: projectExpectedValueTextField.text!)
            }
            
            appData.addToList(newProject)
            
            performSegue(withIdentifier: "unwindToMain", sender: nil)
            
        } else if checkFields() {
            viewProject.updateValues(name: projectNameTextField.text!, address: projectAddressTextField.text!, budget: projectBudgetTextField.text!, startDate: projectStartDateTextField.text!, image: addImageButton.currentBackgroundImage!)
            
            if projectEndDateTextField.text != nil {
                viewProject.setExpectedEndDate(ed: projectEndDateTextField.text!)
            }
            if projectExpectedValueTextField.text != nil {
                viewProject.setExpectedValue(ev: projectExpectedValueTextField.text!)
            }
            
            performSegue(withIdentifier: "undwindToRoom", sender: nil)
            
        }
        
    }
    
    @IBAction func deleteProjectButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure you want to delete this project?", message: "You cannot undo this action", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            appData.removeFromList(self.viewProject)
            self.performSegue(withIdentifier: "unwindToMain", sender: nil)
        }))
        
        self.present(alert, animated: true)
        
    }
    
    
    @IBAction func markCompleteButtonPressed(_ sender: Any) {
    }
    

    @IBAction func cancelButtonPressed(_ sender: Any) {
        if viewProject == nil {
            performSegue(withIdentifier: "unwindToMain", sender: nil)
        } else {
            performSegue(withIdentifier: "undwindToRoom", sender: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
