//
//  NewProjectView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/23/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class NewProjectView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var fullContentView: UIView!
    @IBOutlet weak var optionalContentView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var projectImageButton: UIButton!
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectAddressTextField: UITextField!
    @IBOutlet weak var projectBudgetTextField: UITextField!
    @IBOutlet weak var projectStartDateTextField: UITextField!
    @IBOutlet weak var projectExpectValueTextField: UITextField!
    @IBOutlet weak var projectEndDateTextField: UITextField!
    var textFields: [UITextField]!
    
    @IBOutlet weak var addProjectButton: UIButton!
    @IBOutlet weak var deleteProjectButton: UIButton!
    
    var activeTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        backgroundImage.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields = [projectNameTextField, projectAddressTextField, projectBudgetTextField, projectStartDateTextField, projectExpectValueTextField, projectEndDateTextField]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

        for tf in textFields {
            tf.delegate = self
        }

//        projectEndDateTextField.delegate = self
//        projectStartDateTextField.delegate = self
        
        setupDatePicker()

        projectImageButton.imageView?.contentMode = .scaleAspectFill
        fullContentView.layer.cornerRadius = 8
        optionalContentView.layer.cornerRadius = 8
        addProjectButton.imageView?.contentMode = .scaleAspectFill
        deleteProjectButton.imageView?.contentMode = .scaleAspectFill
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) { }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            (projectImageButton.subviews[0] as? UIImageView)?.contentMode = .scaleAspectFill
            projectImageButton.setBackgroundImage(image, for: .normal)
        } else {
            //Write error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupDatePicker() {
        
        activeTextField = projectNameTextField
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(NewProjectCreationView.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        projectStartDateTextField.inputView = datePicker
        projectEndDateTextField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(self.dismissButtonPressed))
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.nextButtonPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([doneButton, spaceButton, nextButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        for tf in textFields {
            tf.inputAccessoryView = toolBar
        }
        
    }
    
    @objc func nextButtonPressed() {
        let index = textFields.index(of: activeTextField)
        if index! + 1 != textFields.count {
            activeTextField.resignFirstResponder()
            activeTextField = textFields[index! + 1]
            activeTextField.becomeFirstResponder()
        } else {
            dismissButtonPressed()
        }
        
    }
    
    @objc func dismissButtonPressed() {
        self.view.endEditing(true)
    }

    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        activeTextField.text = formatter.string(from: sender.date)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            
            
            print("Moving View")
            let index = textFields.index(of: activeTextField)
            
            self.view.frame.origin.y = CGFloat(-(index! * 40))
            
            
            /*
            var originY = 0
            
            if activeTextField.superview == optionalContentView {
                originY = Int(self.optionalContentView.convert(activeTextField.frame, to: self.view).origin.y)
            } else {
                originY = Int(activeTextField.frame.origin.y)
            }
            
            if CGFloat(originY) + activeTextField.frame.height > self.view.frame.height - keyboardRect.height - 40 {
                self.view.frame.origin.y = CGFloat(-(index! * 40))
                //self.view.frame.origin.y = (CGFloat(originY) - (self.view.frame.height - keyboardRect.height)) - self.view.frame.height / 4
            } else {
                self.view.frame.origin.y = 0
            }
 */
 
        } else if notification.name == Notification.Name.UIKeyboardDidHide {
            self.view.frame.origin.y = 0
        }
        
    }
    
    
    
    @IBAction func addProjectButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func deleteProjectButtonPressed(_ sender: Any) {
        
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
