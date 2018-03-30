//
//  RoomCreationView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/28/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class RoomCreationView: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var containerScrollView: UIScrollView!

    @IBOutlet weak var headerLabel: UILabel!
    
    var nameTextField = UITextField()
    var nameLabel = UILabel()
    
    var typeTextField = UITextField()
    var typeLabel = UILabel()
    var typePickerView = UIPickerView()
    var addTypeButton = UIButton()
    
    var budgetTextField = UITextField()
    var budgetLabel = UILabel()
    
    var addRoomButton = UIButton()
    var deleteRoomButton = UIButton()
    
    var activeTextField: UITextField!
    
    var viewProject: Project!
    var viewRoom: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerScrollView.contentSize = CGSize(width: self.view.frame.width, height: containerScrollView.frame.height)
        containerScrollView.delegate = self
        
        activeTextField = nameTextField
        
        setupTextFields()
        setupButtons()
        
        if viewRoom != nil { fillInfo() }
        if viewProject != nil && viewRoom != nil { viewRoom.roomProject = viewProject }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fillInfo() {
        
        nameTextField.text = viewRoom.roomName
        typeTextField.text = viewRoom.roomType
        budgetTextField.text = viewRoom.getRoomBudget()
        
        headerLabel.text = "Edit Room"
        addRoomButton.setTitle("Save Changes", for: .normal)
        deleteRoomButton.isHidden = false
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func setupTextFields() {
        
        let textFields = [nameTextField, typeTextField, budgetTextField]
        let labels = [nameLabel, typeLabel, budgetLabel]
        
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
        
        
        nameTextField.frame.origin = CGPoint(x: 20, y: Int(headerLabel.frame.origin.y) + 20)
        nameTextField.placeholder = "Room Name"
        nameTextField.autocapitalizationType = .words
        nameTextField.becomeFirstResponder()
        
        nameLabel.frame.origin = CGPoint(x: 20, y: Int(headerLabel.frame.origin.y))
        nameLabel.text = "Room Name"
        
        
        typePickerView.delegate = self
        typePickerView.dataSource = self
        
        typeTextField.frame.origin = CGPoint(x: 20, y: Int(nameTextField.frame.origin.y) + 90)
        typeTextField.placeholder = "Room Type"
        typeTextField.autocapitalizationType = .words
        typeTextField.inputView = typePickerView
        
        typeLabel.frame.origin = CGPoint(x: 20, y: Int(nameTextField.frame.origin.y) + 70)
        typeLabel.text = "Room Type"
        
        
        budgetTextField.frame.origin = CGPoint(x: 20, y: Int(typeTextField.frame.origin.y) + 90)
        budgetTextField.placeholder = "Room Budget"
        budgetTextField.keyboardType = .numberPad
        budgetTextField.addTarget(self, action: #selector(self.textFieldChangedForDollars(textfield:)), for: UIControlEvents.editingChanged)
        
        budgetLabel.frame.origin = CGPoint(x: 20, y: Int(typeTextField.frame.origin.y) + 70)
        budgetLabel.text = "Room Budget"
        
    }
    
    
    @objc func textFieldChangedForDollars(textfield: UITextField) {
        
        textfield.text = ProjectCreationView.formatDollars(textfield.text!)
        
    }
    
    func setupButtons() {
        
        addRoomButton.frame = CGRect(x: 0, y: Int(budgetTextField.frame.origin.y + budgetTextField.frame.height) + 20, width: Int(self.view.frame.width), height: 50)
        addRoomButton.setTitle("+ Add Room", for: .normal)
        addRoomButton.backgroundColor = UIColor(red: 132/255, green: 172/255, blue: 232/255, alpha: 1)
        addRoomButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        addRoomButton.titleLabel?.textColor = UIColor.white
        addRoomButton.addTarget(self, action: #selector(self.addRoomButtonTapped), for: .touchUpInside)
        containerScrollView.addSubview(addRoomButton)
        
        
        deleteRoomButton.frame = CGRect(x: 0, y: Int(addRoomButton.frame.origin.y + addRoomButton.frame.height) + 10, width: Int(self.view.frame.width), height: 50)
        deleteRoomButton.setTitle("Delete Room", for: .normal)
        deleteRoomButton.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        deleteRoomButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        deleteRoomButton.titleLabel?.textColor = UIColor.white
        deleteRoomButton.addTarget(self, action: #selector(self.deleteRoomButtonTapped), for: .touchUpInside)
        deleteRoomButton.isHidden = true
        containerScrollView.addSubview(deleteRoomButton)
        
        
        addTypeButton.frame = CGRect(x: Int(typeTextField.frame.origin.x + typeTextField.frame.width) - 40, y: Int(typeTextField.frame.origin.y) + 10, width: 30, height: 30)
        addTypeButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-add_filled-1"), for: .normal)
        addTypeButton.addTarget(self, action: #selector(self.addTypeButtonPressed), for: .touchUpInside)
        containerScrollView.addSubview(addTypeButton)
        
        
    }
    
    func canCreate() -> Bool {
        
        var canCreate = true
        
        if nameTextField.text == "" {
            nameTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
            canCreate = false
        } else { nameTextField.backgroundColor = UIColor.white }
        
        if typeTextField.text == "" {
            typeTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
            canCreate = false
        } else { typeTextField.backgroundColor = UIColor.white }
        
        if budgetTextField.text == "" || budgetTextField.text == "$" {
            budgetTextField.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
            canCreate = false
        } else { budgetTextField.backgroundColor = UIColor.white }
        
        return canCreate
    }
    
    
    @objc func addRoomButtonTapped() {
        
        if canCreate() && viewRoom == nil {
            let newRoom = Room(name: nameTextField.text!, budget: budgetTextField.text!, type: typeTextField.text!, project: viewProject)
            userData.saveRoom(newRoom)
            viewProject.addRoom(newRoom: newRoom)
            userData.saveProject(viewProject)
            self.view.endEditing(true)
            performSegue(withIdentifier: "undwindToRoom", sender: self)
        } else if canCreate() {
            
        }
        
    }
    
    @objc func deleteRoomButtonTapped() {
        let alert = UIAlertController(title: "Are you sure you want to delete this room?", message: "All expenses in this room will also be delete. This action can not be undone.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.viewRoom.roomProject.removeRoom(self.viewRoom)
            userData.deleteRoom(self.viewRoom)
            self.view.endEditing(true)
            self.performSegue(withIdentifier: "undwindToRoom", sender: self)
        }))
        
        self.present(alert, animated: true)
    }
    
    @objc func addTypeButtonPressed() {
        if addTypeButton.backgroundImage(for: .normal) == #imageLiteral(resourceName: "icons8-add_filled-1") {
            addTypeButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-cancel_filled"), for: .normal)
            typeTextField.inputView = nil
            typeTextField.reloadInputViews()
        } else {
            addTypeButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-add_filled-1"), for: .normal)
            typeTextField.inputView = typePickerView
            typeTextField.reloadInputViews()
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userData.roomTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userData.roomTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = userData.roomTypes[row]
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if viewRoom != nil {
            performSegue(withIdentifier: "undwindToMaterial", sender: self)
        } else {
            performSegue(withIdentifier: "undwindToRoom", sender: self)
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
