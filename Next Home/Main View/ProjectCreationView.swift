//
//  ProjectCreationView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/27/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ProjectCreationView: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    @IBOutlet weak var viewHeaderLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var nameTextField = UITextField()
    var nameLabel = UILabel()
    
    var addressTextField = UITextField()
    var addressLabel = UILabel()
    
    var budgetTextField = UITextField()
    var budgetLabel = UILabel()
    
    var expectValueTextField = UITextField()
    var expectValueLabel = UILabel()
    
    var startDateTextField = UITextField()
    var startDateLabel = UILabel()
    
    var endDateTextField = UITextField()
    var endDateLabel = UILabel()
    
    var imageView = UIImageView()
    var imageLabel = UILabel()
    
    var previousButton = UIButton()
    var nextButton = UIButton()
    var addProjectButton = UIButton()
    var deleteProjectButton = UIButton()
    var markCompleteButton = UIButton()
    
    var canCreateLabel = UILabel()
    
    var activeTextField: UITextField!
    var pageIndex = 0
    
    var viewProject: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerScrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(4), height: containerScrollView.frame.height)
        
        activeTextField = nameTextField
        
        setupTextFields()
        setupImageView()
        setupButtons()
        
        if viewProject != nil {
            fillInfo()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillInfo() {
        
        viewHeaderLabel.text = "Edit Project"
        
        nameTextField.text = viewProject.projectName
        addressTextField.text = viewProject.projectAddress
        budgetTextField.text = viewProject.getBudget()
        startDateTextField.text = viewProject.projectStartDate
        imageView.image = viewProject.projectHomeImage
        
        if viewProject.projectExpectedValue != "N/A" {
            expectValueTextField.text = viewProject.projectExpectedValue
        }
        
        if viewProject.projectExpectedEndDate != "N/A" {
            endDateTextField.text = viewProject.projectExpectedEndDate
        }
        
        addProjectButton.setTitle("Save Changes", for: .normal)
        deleteProjectButton.isHidden = false
        markCompleteButton.isHidden = false
        
    }
    
    func setupTextFields() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let textFields = [nameTextField, addressTextField, budgetTextField, expectValueTextField, startDateTextField, endDateTextField]
        let labels = [nameLabel, addressLabel, budgetLabel, expectValueLabel, startDateLabel, endDateLabel]
        
        for tf in textFields {
            tf.delegate = self
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
            tf.leftView = paddingView
            tf.leftViewMode = .always
            
            tf.frame.size = CGSize(width: Int(self.view.frame.width) - 40, height: 50)
            tf.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85)
            tf.borderStyle = .none
            tf.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 22)
            tf.autocorrectionType = .no
            containerScrollView.addSubview(tf)
        }
        
        for label in labels {
            label.frame.size = CGSize(width: Int(self.view.frame.width) - 40, height: 20)
            label.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 20)
            label.textColor = UIColor.white
            containerScrollView.addSubview(label)
        }
        
        
        nameTextField.frame.origin = CGPoint(x: 20, y: Int(viewHeaderLabel.frame.origin.y) + 40)
        nameTextField.placeholder = "Project Name"
        nameTextField.autocapitalizationType = .words
        nameTextField.becomeFirstResponder()
        
        nameLabel.frame.origin = CGPoint(x: 20, y: Int(viewHeaderLabel.frame.origin.y) + 20)
        nameLabel.text = "Project Name"
        
        
        addressTextField.frame.origin = CGPoint(x: 20, y: Int(nameTextField.frame.origin.y) + 110)
        addressTextField.placeholder = "Project Address"
        addressTextField.autocapitalizationType = .words
        
        addressLabel.frame.origin = CGPoint(x: 20, y: Int(nameTextField.frame.origin.y) + 90)
        addressLabel.text = "Project Address"
        
        
        
        budgetTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) + 20, y: Int(viewHeaderLabel.frame.origin.y) + 40)
        budgetTextField.placeholder = "Project Budget"
        budgetTextField.keyboardType = .numberPad
        budgetTextField.addTarget(self, action: #selector(textFieldChanged(textfield:)), for: UIControlEvents.editingChanged)
        
        budgetLabel.frame.origin = CGPoint(x: Int(self.view.frame.width) + 20, y: Int(viewHeaderLabel.frame.origin.y) + 20)
        budgetLabel.text = "Project Budget"
        
        
        expectValueTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) + 20, y: Int(nameTextField.frame.origin.y) + 110)
        expectValueTextField.placeholder = "Project Expect Value (Optional)"
        expectValueTextField.keyboardType = .numberPad
        expectValueTextField.addTarget(self, action: #selector(textFieldChanged(textfield:)), for: UIControlEvents.editingChanged)
        
        expectValueLabel.frame.origin = CGPoint(x: Int(self.view.frame.width) + 20, y: Int(nameTextField.frame.origin.y) + 90)
        expectValueLabel.text = "Project Expected Value (ARV)"
        
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        startDateTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) * 2 + 20, y: Int(viewHeaderLabel.frame.origin.y) + 40)
        startDateTextField.placeholder = "Project Start Date"
        startDateTextField.inputView = datePicker
        
        startDateLabel.frame.origin = CGPoint(x: Int(self.view.frame.width) * 2 + 20, y: Int(viewHeaderLabel.frame.origin.y) + 20)
        startDateLabel.text = "Project Start Date"
        
        
        endDateTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) * 2 + 20, y: Int(nameTextField.frame.origin.y) + 110)
        endDateTextField.placeholder = "Project Expect End Date (Optional)"
        endDateTextField.inputView = datePicker
        
        endDateLabel.frame.origin = CGPoint(x: Int(self.view.frame.width) * 2 + 20, y: Int(nameTextField.frame.origin.y) + 90)
        endDateLabel.text = "Project Expected End Date"
        
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardDidChangeFrame {
            
            previousButton.frame.origin.y = self.view.frame.height - keyboardFrame.height - 50
            nextButton.frame.origin.y = self.view.frame.height - keyboardFrame.height - 50
            
        } else {
            previousButton.frame.origin.y = markCompleteButton.frame.origin.y + markCompleteButton.frame.height + 50
            nextButton.frame.origin.y = markCompleteButton.frame.origin.y + markCompleteButton.frame.height + 50
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    @objc func textFieldChanged(textfield: UITextField) {
        
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
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        activeTextField.text = formatter.string(from: sender.date)
    }
    
    
    
    func setupImageView() {
        
        imageView.frame = CGRect(x: Int(self.view.frame.width) * 3 + 20, y: Int(viewHeaderLabel.frame.origin.y) + 40, width: Int(self.view.frame.width) - 40, height: Int(Double(self.view.frame.width) * 0.49))
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "AddImage")
        imageView.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        containerScrollView.addSubview(imageView)
        
        
        imageLabel.frame = CGRect(x: Int(self.view.frame.width) * 3 + 20, y: Int(viewHeaderLabel.frame.origin.y) + 20, width: Int(self.view.frame.width) - 40, height: 20)
        imageLabel.text = "Project Image"
        imageLabel.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 20)
        imageLabel.textColor = UIColor.white
        containerScrollView.addSubview(imageLabel)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) { }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else {
            //Write error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupButtons() {
        
        addProjectButton.frame = CGRect(x: Int(self.view.frame.width) * 3, y: Int(imageView.frame.origin.y + imageView.frame.height) + 20, width: Int(self.view.frame.width), height: 50)
        addProjectButton.setTitle("+ Add Project", for: .normal)
        addProjectButton.backgroundColor = UIColor(red: 132/255, green: 172/255, blue: 232/255, alpha: 1)
        addProjectButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        addProjectButton.titleLabel?.textColor = UIColor.white
        addProjectButton.addTarget(self, action: #selector(self.addProjectButtonTapped), for: .touchUpInside)
        containerScrollView.addSubview(addProjectButton)
        
        
        deleteProjectButton.frame = CGRect(x: Int(self.view.frame.width) * 3, y: Int(addProjectButton.frame.origin.y + addProjectButton.frame.height) + 20, width: Int(self.view.frame.width), height: 50)
        deleteProjectButton.setTitle("Delete Project", for: .normal)
        deleteProjectButton.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        deleteProjectButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        deleteProjectButton.titleLabel?.textColor = UIColor.white
        deleteProjectButton.addTarget(self, action: #selector(self.deleteButtonTapped), for: .touchUpInside)
        deleteProjectButton.isHidden = true
        containerScrollView.addSubview(deleteProjectButton)
        
        markCompleteButton.frame = CGRect(x: Int(self.view.frame.width) * 3, y: Int(deleteProjectButton.frame.origin.y + deleteProjectButton.frame.height) + 20, width: Int(self.view.frame.width), height: 50)
        markCompleteButton.setTitle("Mark Project Complete", for: .normal)
        markCompleteButton.backgroundColor = UIColor(red: 0/255, green: 105/255, blue: 0/255, alpha: 1)
        markCompleteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        markCompleteButton.titleLabel?.textColor = UIColor.white
        markCompleteButton.addTarget(self, action: #selector(self.markCompleteButtonTapped), for: .touchUpInside)
        markCompleteButton.isHidden = true
        containerScrollView.addSubview(markCompleteButton)
        
        
        previousButton.frame = CGRect(x: 20, y: Int(markCompleteButton.frame.origin.y + markCompleteButton.frame.height) + 50, width: 30, height: 30)
        previousButton.isHidden = true
        previousButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-circled_chevron_left_filled"), for: .normal)
        previousButton.addTarget(self, action: #selector(self.previousButtonTapped), for: .touchUpInside)
        self.view.addSubview(previousButton)
        
        nextButton.frame = CGRect(x: Int(self.view.frame.width) - 50, y: Int(markCompleteButton.frame.origin.y + markCompleteButton.frame.height) + 50, width: 30, height: 30)
        nextButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-circled_chevron_right_filled"), for: .normal)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        
        canCreateLabel.frame = CGRect(x: self.view.frame.width * 3 + previousButton.frame.origin.x + 50, y: previousButton.frame.origin.y, width: self.view.frame.width - 100, height: 60)
        canCreateLabel.isHidden = true
        canCreateLabel.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 22)
        canCreateLabel.textColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        canCreateLabel.numberOfLines = 2
        canCreateLabel.text = "You have not filled out all required fields"
        containerScrollView.addSubview(canCreateLabel)
        
        
    }
    
    @objc func previousButtonTapped() {
        
        pageIndex -= 1
        
        switch pageIndex {
        case 0:
            previousButton.isHidden = true
            nextButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: nameTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = nameTextField
            activeTextField.becomeFirstResponder()
            
        case 1:
            previousButton.isHidden = false
            previousButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: budgetTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = budgetTextField
            activeTextField.becomeFirstResponder()
            
        case 2:
            previousButton.isHidden = false
            nextButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: startDateTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = startDateTextField
            activeTextField.becomeFirstResponder()
            
        default:
            previousButton.isHidden = true
            containerScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
    }
    
    @objc func nextButtonTapped() {
        
        pageIndex += 1
        
        switch pageIndex {
        case 1:
            nextButton.isHidden = false
            previousButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: budgetTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = budgetTextField
            activeTextField.becomeFirstResponder()
            
        case 2:
            nextButton.isHidden = false
            previousButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: startDateTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = startDateTextField
            activeTextField.becomeFirstResponder()
            
        case 3:
            nextButton.isHidden = true
            previousButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: imageView.frame.origin.x - 20, y: 0), animated: true)
            
            self.view.endEditing(true)
            
        default:
            previousButton.isHidden = true
            containerScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
    }
    
     @objc func addProjectButtonTapped() {
        
        if checkFields() && viewProject == nil {
            let newProject = Project(name: nameTextField.text!, address: addressTextField.text!, budget: budgetTextField.text!, startDate: startDateTextField.text!, image: imageView.image!)
            
            if let endDate = endDateTextField.text {
                newProject.setExpectedEndDate(ed: endDate)
            }
            
            if let value = expectValueTextField.text {
                newProject.setExpectedValue(ev: value)
            }
            
            appData.addToList(newProject)
            
            performSegue(withIdentifier: "unwindToMain", sender: nil)
            
        } else if checkFields() {
            viewProject.updateValues(name: nameTextField.text!, address: addressTextField.text!, budget: budgetTextField.text!, startDate: startDateTextField.text!, image: imageView.image!)
            
            if let endDate = endDateTextField.text {
                viewProject.setExpectedEndDate(ed: endDate)
            }
            
            if expectValueTextField.text != nil && expectValueTextField.text != "$" {
                viewProject.setExpectedValue(ev: expectValueTextField.text!)
            } else {
                viewProject.setExpectedValue(ev: "N/A")
            }
            
            performSegue(withIdentifier: "undwindToRoom", sender: nil)
        } else {
            canCreateLabel.isHidden = false
        }
        
    }
    
    @objc func deleteButtonTapped() {
        
        let alert = UIAlertController(title: "Are you sure you want to delete this project?", message: "You cannot undo this action", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            appData.removeFromList(self.viewProject)
            self.performSegue(withIdentifier: "unwindToMain", sender: nil)
        }))
        
        self.present(alert, animated: true)
        
    }
    
    @objc func markCompleteButtonTapped() {
        
    }
    
    func checkFields() -> Bool {
        
        var canCreate = true
        
        if nameTextField.text == "" {
            canCreate = false
            nameTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { nameTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85) }
        
        if addressTextField.text == "" {
            canCreate = false
            addressTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { addressTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85) }
        
        if startDateTextField.text == "" {
            canCreate = false
            startDateTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { startDateTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85) }
        
        if budgetTextField.text == "$" || budgetTextField.text == "" {
            canCreate = false
            budgetTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { budgetTextField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85) }
        
        if imageView.image == #imageLiteral(resourceName: "AddImage") {
            canCreate = false
            imageView.tintColor = UIColor.red
        }
        
        return canCreate
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.view.endEditing(true)
        
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
