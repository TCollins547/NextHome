//
//  NewRoomCreationView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/9/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class NewRoomCreationView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var roomAreaTextField: UITextField!
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomBudgetTextField: UITextField!
    
    @IBOutlet weak var areaButton: UIButton!
    
    var parentView: RoomViewController!
    var viewProject: Project!
    
    let pickerView = UIPickerView()
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        roomAreaTextField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    
    func connectParentView(pView: RoomViewController, project: Project) {
        parentView = pView
        viewProject = project
        if viewProject.rooms.count == 0 {
            roomAreaTextField.inputView = nil
            roomAreaTextField.reloadInputViews()
        } else {
            roomAreaTextField.text = Array(parentView.viewProject.rooms.keys)[0]
            pickerView.reloadAllComponents()
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewProject.rooms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(viewProject.rooms.keys)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roomAreaTextField.text = Array(viewProject.rooms.keys)[row]
    }
    
    @IBAction func createNewAreaButtonPressed(_ sender: Any) {
        if areaButton.currentBackgroundImage == #imageLiteral(resourceName: "icons8-add_filled-1") && parentView.viewProject.rooms.count > 0 {
            areaButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-xbox_menu_filled-1"), for: .normal)
            roomAreaTextField.inputView = nil
            roomAreaTextField.text = ""
            roomAreaTextField.reloadInputViews()
        } else if areaButton.currentBackgroundImage == #imageLiteral(resourceName: "icons8-xbox_menu_filled-1") {
            areaButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-add_filled-1"), for: .normal)
            roomAreaTextField.inputView = pickerView
            roomAreaTextField.text = Array(parentView.viewProject.rooms.keys)[0]
            roomAreaTextField.reloadInputViews()
        }
    }
    
    @IBAction func addRoomButtonPressed(_ sender: Any) {
        
        var canCreate = true
        
        if roomAreaTextField.text == "" {
            canCreate = false
            roomAreaTextField.backgroundColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
        
        if roomBudgetTextField.text == "" {
            canCreate = false
            roomBudgetTextField.backgroundColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
        
        if roomNameTextField.text == "" {
            canCreate = false
            roomNameTextField.backgroundColor = UIColor(red: 253/255, green: 129/255, blue: 138/255, alpha: 1)
        }
        
        if canCreate {
            addRoom()
        }
    }
    
    func addRoom() {
        let newRoom = Room(name: roomNameTextField.text!, budget: roomBudgetTextField.text!, project: parentView.viewProject)
        viewProject.addRoom(newRoom: newRoom, section: roomAreaTextField.text!)
        parentView.projectAreas = Array(viewProject.rooms.keys)
        parentView.projectRooms = Array(viewProject.rooms.values)
        parentView.roomTableView.reloadData()
        cancelButtonPressed(self)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        parentView.cancelRoomCreate()
        self.endEditing(true)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
