//
//  ExpenseCreationView.swift
//  Next Home
//
//  Created by Tyler Collins on 3/2/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ExpenseCreationView: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var containerScrollView: UIScrollView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    //For both
    
    var nameTextField = UITextField()
    var nameLabel = UILabel()
    
    var typeTextField = UITextField()
    var typeLabel = UILabel()
    
    var noteTextView = UITextView()
    var noteLabel = UILabel()
    
    var totalTextField = UITextField()
    var totalLabel = UILabel()
    
    var image = UIImageView()
    var imageLabel = UILabel()
    
    var phoneTextField = UITextField()
    var phoneLabel = UILabel()
    
    //For Material
    
    var unitTextField = UITextField()
    var unitLabel = UILabel()
    
    var unitCostTextField = UITextField()
    var unitCostLabel = UILabel()
    
    var unitsBoughtTextField = UITextField()
    var unitsBoughtLabel = UILabel()
    
    var unitsUsedTextField = UITextField()
    var unitsUsedLabel = UILabel()
    
    var overrideLabel = UILabel()
    
    var locationTextField = UITextField()
    var addressTextField = UITextField()
    var placeLabel = UILabel()
    
    var webTextField = UITextField()
    var webLabel = UILabel()
    
    var recipt = UIImageView()
    var reciptLabel = UILabel()
    
    //For Service
    
    var providerTextField = UITextField()
    var providerLabel = UILabel()
    
    var emailTextField = UITextField()
    var emailLabel = UILabel()
    
    //Buttons
    
    var addExpenseButton = UIButton()
    
    var nextButton = UIButton()
    var previousButton = UIButton()
    
    
    var selectedImage: UIImageView!
    var activeTextField: UITextField!
    var pageIndex = 0
    
    var expenseType: String!
    
    var viewRoom: Room!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupTextFields() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        headerLabel.text = "New " + expenseType!
        containerScrollView.delegate = self
        
        if expenseType == "Service" {
            setupService()
        } else {
            setupMaterial()
        }
        
        setupButtons()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != self.view.frame.width * CGFloat(pageIndex) {
            //scrollView.contentOffset.x = self.view.frame.width * CGFloat(pageIndex)
        }
    }
    
    func setupService() {
        
    }
    
    func setupMaterial() {
        
        containerScrollView.contentSize = CGSize(width: self.view.frame.width * 7, height: self.view.frame.height)
        
        let textFields = [nameTextField, typeTextField, totalTextField, phoneTextField, unitTextField, unitCostTextField, unitsBoughtTextField, unitsUsedTextField, locationTextField, addressTextField, webTextField]
        let labels = [nameLabel, typeLabel, noteLabel, totalLabel, overrideLabel, phoneLabel, unitLabel, unitCostLabel, unitsBoughtLabel, unitsUsedLabel, placeLabel, webLabel, imageLabel, reciptLabel]
        
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
        
        nameTextField.frame.origin = CGPoint(x: 20, y: Int(headerLabel.frame.origin.y) + 40)
        nameTextField.placeholder = "Material Name"
        nameTextField.autocapitalizationType = .words
        nameTextField.becomeFirstResponder()
        
        nameLabel.frame.origin = CGPoint(x: 20, y: Int(headerLabel.frame.origin.y) + 20)
        nameLabel.text = "Material Name"
        
        
        typeTextField.frame.origin = CGPoint(x: 20, y: Int(nameTextField.frame.origin.y) + 110)
        typeTextField.placeholder = "Material Type"
        typeTextField.autocapitalizationType = .words
        
        typeLabel.frame.origin = CGPoint(x: 20, y: Int(nameTextField.frame.origin.y) + 90)
        typeLabel.text = "Material Type"
        
        
        
        
        unitTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) + 20, y: Int(headerLabel.frame.origin.y) + 40)
        unitTextField.placeholder = "Unit Size"
        unitTextField.autocapitalizationType = .words
        
        unitLabel.frame.origin = CGPoint(x: Int(unitTextField.frame.origin.x), y: Int(headerLabel.frame.origin.y) + 20)
        unitLabel.text = "Unit Size"
        
        
        unitCostTextField.frame.origin = CGPoint(x: Int(unitTextField.frame.origin.x), y: Int(unitTextField.frame.origin.y) + 110)
        unitCostTextField.addTarget(self, action: #selector(self.textFieldDidChangeForDollar(textfield:)), for: UIControlEvents.editingChanged)
        unitCostTextField.placeholder = "Unit Cost"
        unitCostTextField.keyboardType = .decimalPad
        
        unitCostLabel.frame.origin = CGPoint(x: Int(unitTextField.frame.origin.x), y: Int(unitTextField.frame.origin.y) + 90)
        unitCostLabel.text = "Unit Cost"
        
        
        
        unitsBoughtTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) * 2 + 20, y: Int(headerLabel.frame.origin.y) + 40)
        unitsBoughtTextField.placeholder = "Units Bought"
        unitsBoughtTextField.keyboardType = .decimalPad
        
        unitsBoughtLabel.frame.origin = CGPoint(x: Int(unitsBoughtTextField.frame.origin.x), y: Int(headerLabel.frame.origin.y) + 20)
        unitsBoughtLabel.text = "Units Bought"
        
        
        unitsUsedTextField.frame.origin = CGPoint(x: Int(unitsBoughtTextField.frame.origin.x), y: Int(unitTextField.frame.origin.y) + 110)
        unitsUsedTextField.placeholder = "Units Used"
        unitsUsedTextField.keyboardType = .decimalPad
        
        unitsUsedLabel.frame.origin = CGPoint(x: Int(unitsBoughtTextField.frame.origin.x), y: Int(unitTextField.frame.origin.y) + 90)
        unitsUsedLabel.text = "Units Used"
        
        
        
        totalTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) * 3 + 20, y: Int(headerLabel.frame.origin.y) + 40)
        totalTextField.addTarget(self, action: #selector(self.textFieldDidChangeForDollar(textfield:)), for: UIControlEvents.editingChanged)
        totalTextField.placeholder = "Total Cost"
        totalTextField.keyboardType = .decimalPad
        
        totalLabel.frame.origin = CGPoint(x: Int(totalTextField.frame.origin.x), y: Int(headerLabel.frame.origin.y) + 20)
        totalLabel.text = "Total Cost"
        
        overrideLabel.frame.origin = CGPoint(x: Int(totalTextField.frame.origin.x), y: Int(unitTextField.frame.origin.y) + 90)
        overrideLabel.frame.size = CGSize(width: Int(self.view.frame.width) - 40, height: 40)
        overrideLabel.numberOfLines = 3
        overrideLabel.lineBreakMode = .byWordWrapping
        overrideLabel.textAlignment = .center
        overrideLabel.text = "Value is the total cost of the material bought including tax, discounts, etc."
        overrideLabel.sizeToFit()
        
        
        
        locationTextField.frame.origin = CGPoint(x: Int(self.view.frame.width) * 4 + 20, y: Int(headerLabel.frame.origin.y) + 20)
        locationTextField.placeholder = "Vendor Name"
        locationTextField.autocapitalizationType = .words
        
        addressTextField.frame.origin = CGPoint(x: Int(locationTextField.frame.origin.x), y: Int(headerLabel.frame.origin.y) + 72)
        addressTextField.placeholder = "Vendor Address"
        addressTextField.autocapitalizationType = .words
        
        placeLabel.frame.origin = CGPoint(x: Int(locationTextField.frame.origin.x), y: Int(headerLabel.frame.origin.y))
        placeLabel.text = "Vendor Bought From"
        
        
        phoneTextField.frame.origin = CGPoint(x: Int(addressTextField.frame.origin.x), y: Int(addressTextField.frame.origin.y) + 90)
        phoneTextField.addTarget(self, action: #selector(self.textFieldDidChangeForPhone(textfield:)), for: UIControlEvents.editingChanged)
        phoneTextField.placeholder = "Phone Number"
        phoneTextField.keyboardType = .phonePad
        
        phoneLabel.frame.origin = CGPoint(x: Int(addressTextField.frame.origin.x), y: Int(addressTextField.frame.origin.y) + 70)
        phoneLabel.text = "Vendor Phone Number"
        
        
        webTextField.frame.origin = CGPoint(x: Int(phoneTextField.frame.origin.x), y: Int(phoneTextField.frame.origin.y) + 90)
        webTextField.placeholder = "Website"
        webTextField.autocapitalizationType = .none
        webTextField.keyboardType = .webSearch
        
        webLabel.frame.origin = CGPoint(x: Int(phoneTextField.frame.origin.x), y: Int(phoneTextField.frame.origin.y) + 70)
        webLabel.text = "Vendor Website"
        
        
        
        noteTextView.frame = CGRect(x: Int(self.view.frame.width) * 5 + 20, y: Int(headerLabel.frame.origin.y) + 20, width: Int(self.view.frame.width) - 40, height: Int(self.view.frame.height) / 3)
        noteTextView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85)
        noteTextView.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 22)
        containerScrollView.addSubview(noteTextView)
        
        noteLabel.frame.origin = CGPoint(x: Int(noteTextView.frame.origin.x), y: Int(headerLabel.frame.origin.y))
        noteLabel.text = "Notes"
        
        
        
        image.frame = CGRect(x: Int(self.view.frame.width) * 6 + 20, y: Int(headerLabel.frame.origin.y) + 20, width: Int(self.view.frame.width) - 40, height: Int(self.view.frame.height) / 5)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "AddImage")
        containerScrollView.addSubview(image)
        
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(imageTapGestureRecognizer)
        
        imageLabel.frame.origin = CGPoint(x: Int(image.frame.origin.x), y: Int(headerLabel.frame.origin.y))
        imageLabel.text = "Material Image"
        
        
        recipt.frame = CGRect(x: Int(self.view.frame.width) * 6 + 20, y: Int(image.frame.origin.y + image.frame.size.height) + 40, width: Int(self.view.frame.width) - 40, height: Int(self.view.frame.height) / 5)
        recipt.contentMode = .scaleAspectFill
        recipt.clipsToBounds = true
        recipt.image = #imageLiteral(resourceName: "AddImage")
        containerScrollView.addSubview(recipt)
        
        let reciptTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(reciptTapped(tapGestureRecognizer:)))
        recipt.isUserInteractionEnabled = true
        recipt.addGestureRecognizer(reciptTapGestureRecognizer)
        
        reciptLabel.frame.origin = CGPoint(x: Int(image.frame.origin.x), y: Int(image.frame.origin.y + image.frame.size.height) + 20)
        reciptLabel.text = "Material Recipt Image"
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let image = UIImagePickerController()
        selectedImage = self.image
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) { }
    }
    
    @objc func reciptTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let image = UIImagePickerController()
        selectedImage = recipt
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) { }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage.image = image
        } else {
            //Write error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupButtons() {
        
        addExpenseButton.frame = CGRect(x: Int(image.frame.origin.x) - 20, y: Int(recipt.frame.origin.y + image.frame.height) + 20, width: Int(self.view.frame.width), height: 50)
        addExpenseButton.setTitle("+ Add \(expenseType!)", for: .normal)
        addExpenseButton.backgroundColor = UIColor(red: 132/255, green: 172/255, blue: 232/255, alpha: 1)
        addExpenseButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        addExpenseButton.titleLabel?.textColor = UIColor.white
        addExpenseButton.addTarget(self, action: #selector(self.addExpenseButtonPressed), for: .touchUpInside)
        containerScrollView.addSubview(addExpenseButton)
        
        previousButton.frame = CGRect(x: 20, y: Int(addExpenseButton.frame.origin.y + addExpenseButton.frame.height) + 50, width: 30, height: 30)
        previousButton.isHidden = true
        previousButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-circled_chevron_left_filled"), for: .normal)
        previousButton.addTarget(self, action: #selector(self.previousButtonTapped), for: .touchUpInside)
        self.view.addSubview(previousButton)
        
        nextButton.frame = CGRect(x: Int(self.view.frame.width) - 50, y: Int(addExpenseButton.frame.origin.y + addExpenseButton.frame.height) + 50, width: 30, height: 30)
        nextButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-circled_chevron_right_filled"), for: .normal)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
    }
    
    
    @objc func addExpenseButtonPressed() {
        
        if expenseType == "Service" {
            if checkService() {
                //Add to userdata
            }
        } else {
            if checkMaterial() {
                
                let tCost = Double((totalTextField.text)!.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ""))
                let uCost = Double((unitCostTextField.text)!.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ""))
                
                let newMaterial = Material(iName: nameTextField.text!, iType: typeTextField.text!, tCost: tCost!, uType: unitTextField.text!, uCost: uCost!, materialImage: image.image!)
                if let units = Double(unitsBoughtTextField.text!) { newMaterial.setBought(units) }
                if let used = Double(unitsUsedTextField.text!) { newMaterial.setUsed(used) }
                if let name = locationTextField.text, let address = addressTextField.text { newMaterial.setStore(name, address) }
                if let website = webTextField.text { newMaterial.setWebsite(website) }
                if let phone = phoneTextField.text { newMaterial.setPhone(phone) }
                if let note = noteTextView.text { newMaterial.setNote(note) }
                
                if recipt.image != nil && recipt.image != #imageLiteral(resourceName: "AddImage") { newMaterial.setReciptImage(recipt.image!) }
                
                userData.saveExpense(newMaterial)
                viewRoom.addExpense(newMaterial)
                
                performSegue(withIdentifier: "undwindToExpense", sender: self)
                
            }
        }
        
    }
    
    @objc func textFieldDidChangeForDollar(textfield: UITextField) {
        textfield.text = ExpenseCreationView.currencyInputFormatting(textfield.text!)
    }
    
    static func currencyInputFormatting(_ inputNumber: String) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = inputNumber
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, inputNumber.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    
    
    @objc func textFieldDidChangeForPhone(textfield: UITextField) {
        let textFieldValue = textfield.text?.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
        
        switch textFieldValue!.count {
        case 3:
            let newValue = "(" + textFieldValue! + ") "
            textfield.text = newValue
        case 6:
            let newValue = "(" + textFieldValue!.prefix(3) + ") " + textFieldValue!.suffix(3) + " - "
            textfield.text = newValue
        case 10..<100:
            let startIndex = textFieldValue?.index(textFieldValue!.startIndex, offsetBy: 3)
            let endIndex = textFieldValue?.index(textFieldValue!.endIndex, offsetBy: -4)
            let range = startIndex!..<endIndex!
            
            let start = textFieldValue?.index(textFieldValue!.startIndex, offsetBy: 6)
            let end = textFieldValue?.index(textFieldValue!.startIndex, offsetBy: 10)
            let endRange = start!..<end!
            
            let newValue = "(\(textFieldValue!.prefix(3))) \(textFieldValue![range]) - \(textFieldValue![endRange])"
            textfield.text = newValue
        default: break
        }
        
    }
    
    
    func checkService() -> Bool {
       return true
    }
    
    func checkMaterial() -> Bool {
        var canCreate = true
        
        if nameTextField.text == nil || nameTextField.text == "" {
            canCreate = false
            nameTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { nameTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85) }
        
        if typeTextField.text == nil || typeTextField.text == "" {
            canCreate = false
            typeTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { typeTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85) }
        
        if unitCostTextField.text == nil || unitCostTextField.text == "$" {
            canCreate = false
            unitCostTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { unitCostTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85) }
        
        if unitsBoughtTextField.text == nil || typeTextField.text == "" {
            canCreate = false
            unitsBoughtTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { unitsBoughtTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85) }
        
        if totalTextField.text == nil || totalTextField.text == "$" {
            canCreate = false
            totalTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { totalTextField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.85) }
        
        if image.image == #imageLiteral(resourceName: "AddImage") {
            canCreate = false
            image.tintColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        } else { image.tintColor = nil }
        
        return canCreate
    }
    
    
    
    @objc func deleteExpenseButtonPressed() {
        
    }
    
    
    @objc func previousButtonTapped() {
        
        pageIndex -= 1
        
        switch pageIndex {
        case 0:
            previousButton.isHidden = true
            containerScrollView.setContentOffset(CGPoint(x: nameTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = nameTextField
            activeTextField.becomeFirstResponder()
            
        case 1:
            previousButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: unitTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = unitTextField
            activeTextField.becomeFirstResponder()
            
        case 2:
            containerScrollView.setContentOffset(CGPoint(x: unitsBoughtTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = unitsBoughtTextField
            activeTextField.becomeFirstResponder()
            
        case 3:
            containerScrollView.setContentOffset(CGPoint(x: totalTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = totalTextField
            activeTextField.becomeFirstResponder()
            
        case 4:
            containerScrollView.setContentOffset(CGPoint(x: locationTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = locationTextField
            activeTextField.becomeFirstResponder()
            
        case 5:
            nextButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: noteTextView.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            noteTextView.becomeFirstResponder()
            
        default:
            previousButton.isHidden = true
            containerScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
    }
    
    @objc func nextButtonTapped() {
        
        pageIndex += 1
        
        switch pageIndex {
        case 1:
            previousButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: unitTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = unitTextField
            activeTextField.becomeFirstResponder()
            
        case 2:
            containerScrollView.setContentOffset(CGPoint(x: unitsBoughtTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = unitsBoughtTextField
            activeTextField.becomeFirstResponder()
            
        case 3:
            containerScrollView.setContentOffset(CGPoint(x: totalTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = totalTextField
            activeTextField.becomeFirstResponder()
            
        case 4:
            containerScrollView.setContentOffset(CGPoint(x: locationTextField.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            activeTextField = locationTextField
            activeTextField.becomeFirstResponder()
            
        case 5:
            nextButton.isHidden = false
            containerScrollView.setContentOffset(CGPoint(x: noteTextView.frame.origin.x - 20, y: 0), animated: true)
            
            activeTextField.resignFirstResponder()
            noteTextView.becomeFirstResponder()
            
        case 6:
            nextButton.isHidden = true
            self.view.endEditing(true)
            
            containerScrollView.setContentOffset(CGPoint(x: image.frame.origin.x - 20, y: 0), animated: true)
            
        default:
            previousButton.isHidden = true
            containerScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
    }
    
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardDidChangeFrame {
            
            previousButton.frame.origin.y = self.view.frame.height - keyboardFrame.height - 50
            nextButton.frame.origin.y = self.view.frame.height - keyboardFrame.height - 50
            
        } else {
            previousButton.frame.origin.y = addExpenseButton.frame.origin.y + addExpenseButton.frame.height + 50
            nextButton.frame.origin.y = addExpenseButton.frame.origin.y + addExpenseButton.frame.height + 50
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        performSegue(withIdentifier: "undwindToExpense", sender: self)
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
