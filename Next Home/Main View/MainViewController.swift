//
//  MainViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 1/22/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchbar: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var selectedID = String()
    
    var blurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var searchAddConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuEdgeConstraint: NSLayoutConstraint!
    
    var newProjectCreationView: NewProjectCreationView!
    
    
    struct UserItems {
        static var userProjects = [Project]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testProject = Project(id: UUID().uuidString, name: "West Hills", address: "10937 West Hills Rd", budget: "10000", image: #imageLiteral(resourceName: "Unique-Spanish-Style-House-Colors"))
        UserItems.userProjects.insert(testProject, at: 0)
        
        //Used to call method that triggers when keyboard shows
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returns the amount rows in the project table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserItems.userProjects.count + 1
    }
    
    // Creates a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //This places the create new project at the end of the table
        if indexPath.row == UserItems.userProjects.count {
            
            //Creates a cell and a create project view
            let cell: CreateTableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellCreateReuseID") as! CreateTableViewCell?)!
            
            cell.selectionStyle = .none
            cell.createView.layer.cornerRadius = 8
            
            return cell
            
        } else {
        
            //Creates a cell and a project view
            let cell: ProjectTableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellReuseID") as! ProjectTableViewCell?)!
            
            //Fills info of project view
            cell.projectTitleLabel.text = UserItems.userProjects[indexPath.row].projectName
            cell.projectAddressLabel.text = UserItems.userProjects[indexPath.row].projectAddress
            cell.projectBudgetLabel.text = "$" + UserItems.userProjects[indexPath.row].projectRunningTab
            cell.projectImage.image = UserItems.userProjects[indexPath.row].projectImage
            
            cell.setProjectID(proID: UserItems.userProjects[indexPath.row].projectIdentifier)
            
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
    // Method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) is CreateTableViewCell {
            addButtonPressed((Any).self)
        } else {
            selectedID = ((tableView.cellForRow(at: indexPath) as? ProjectTableViewCell)?.projectID)!
            performSegue(withIdentifier: "showRoomView", sender: (Any).self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RoomViewController {
            destination.projectID = selectedID
        }
    }
    
    
    //Handles menu button tap
    @IBAction func menuButtonPressed(_ sender: Any) {
    }
    
    //Handles add button press and also handles search cancel when applicable
    @IBAction func addButtonPressed(_ sender: Any) {
        
        //Triggers when the search is in use
        if !searchbar.isHidden {
            
            //Animates the search button back and rotates itself back
            UIView.animate(withDuration: 0.25, animations: {
                self.searchAddConstraint.constant = 5
                self.addButton.transform = CGAffineTransform(rotationAngle: (0 * .pi) / 180.0)
                
                self.searchbar.alpha = 0
                self.blurEffectView.alpha = 0
                
            }, completion: { finished in
                self.searchbar.isHidden = true
                self.blurEffectView.isHidden = true
            })
            
            self.searchButton.isEnabled = true
            
        } else {
            
            //Creates a create new project view
            newProjectCreationView = Bundle.main.loadNibNamed("NewProjectCreationView", owner: self, options: nil)?.first as! NewProjectCreationView
            newProjectCreationView.connectParentView(connectView: self)

            //Summons keyboard when view is added
            newProjectCreationView.frame.size = CGSize(width: self.view.frame.width - 20, height: newProjectCreationView.frame.height)
            newProjectCreationView.frame.origin = CGPoint(x: 10, y: newProjectCreationView.frame.height * -1)
            newProjectCreationView.projectTitleTextField.becomeFirstResponder()
            
            //Generates and sizes blur view
            blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
            blurEffectView.frame = self.view.bounds
            blurEffectView.alpha = 0
            
            //Adds blur and view
            self.view.addSubview(blurEffectView)
            self.view.addSubview(newProjectCreationView)
            
            //Animates view and blur coming in
            UIView.animate(withDuration: 0.5, animations: {
                
                self.blurEffectView.alpha = 1
                self.newProjectCreationView.frame.origin = CGPoint(x: 10, y: UIApplication.shared.statusBarFrame.height + 10)
                
            }, completion: nil)
            
        }
        
    }
    
    //Handles search button press
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        searchButton.isEnabled = false
        self.searchButton.adjustsImageWhenDisabled = false
        
        //Creates and adds blur effect
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurEffectView.frame = self.view.bounds
        view.addSubview(blurEffectView)
        
        //Makes searchbar and blur opaque
        searchbar.alpha = 0
        searchbar.isHidden = true
        blurEffectView.isHidden = true
        blurEffectView.alpha = 0
        
        //Brings subviews to front
        self.view.bringSubview(toFront: searchbar); self.view.bringSubview(toFront: searchButton); self.view.bringSubview(toFront: addButton)
        
        //Animates searchbar and blur fade + search button to edge
        UIView.animate(withDuration: 0.25, animations: {
            
            self.searchAddConstraint.constant = self.view.frame.width - 80
            self.addButton.transform = CGAffineTransform(rotationAngle: (45.0 * .pi) / 180.0)
            
            self.searchbar.isHidden = false
            self.searchbar.alpha = 1
            self.blurEffectView.isHidden = false
            self.blurEffectView.alpha = 1
            
        }, completion: nil)
        
    }
    
//    //Called when keyboard is shown
//    @objc func keyboardShown(notification: NSNotification) {
//        let value = notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject
//        let rawFrame = value.cgRectValue
//        let keyboardFrame = view.convert(rawFrame!, from: nil)
//
//
//    }
    
    func cancelProjectCreate() {
        
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.newProjectCreationView.frame.origin = CGPoint(x: self.newProjectCreationView.frame.origin.x, y: self.newProjectCreationView.frame.height * -1)
            self.blurEffectView.alpha = 0
            
        }, completion: { finished in
            self.newProjectCreationView.isHidden = true
            self.blurEffectView.isHidden = true
        })
        
    }
    
    func addProject() {
        
        let newProject = Project(id: UUID().uuidString, name: newProjectCreationView.projectTitleTextField.text!, address: newProjectCreationView.projectAddressTextField.text!, budget: newProjectCreationView.projectBudgetTextField.text!, image: newProjectCreationView.projectImage.currentBackgroundImage!)
        UserItems.userProjects.insert(newProject, at: 0)
        
        cancelProjectCreate()
        
        tableView.reloadData()
        
    }
    
    @IBAction func undwindSegue(_ sender: UIStoryboardSegue) {}
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
