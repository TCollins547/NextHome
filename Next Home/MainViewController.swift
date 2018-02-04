//
//  MainViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 1/22/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchbar: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var userProjects: [Project]!
    
    var blurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var searchAddConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuEdgeConstraint: NSLayoutConstraint!
    
    var newProjectCreationView: NewProjectCreationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nc = NotificationCenter.default
//        nc.addObserver(self, selector: #selector(printValue), name: NSNotification.Name(rawValue: "printValue"), object: nil)
        
        //Used to call method that triggers when keyboard shows
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let testImage = UIImage(named: "Unique-Spanish-Style-House-Colors")!
            
        let project1 = Project(id: 0, name: "West Hills", address: "23850 West Hills Ln", tab: "84,297", image: testImage)
        let project2 = Project(id: 1, name: "Valley", address: "98439 Lake View Rd", tab: "28,297", image: testImage)
        let project3 = Project(id: 2, name: "Coolage", address: "59487 Harrington St", tab: "83,298", image: testImage)
        let project4 = Project(id: 3, name: "Arington", address: "12043 Arington Ct", tab: "34,297", image: testImage)
        
        userProjects = [project1, project2, project3, project4]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returns the amount rows in the project table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProjects.count + 1
    }
    
    // Creates a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //This places the create new project at the end of the table
        if indexPath.row == userProjects.count {
            
            //Creates a cell and a create project view
            let cell: CreateTableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellCreateReuseID") as! CreateTableViewCell?)!
            
            cell.createView.layer.cornerRadius = 8
            
            return cell
            
        }
        
        //Creates a cell and a project view
        let cell: ProjectTableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellReuseID") as! ProjectTableViewCell?)!
        
        //Fills info of project view
        cell.projectTitleLabel.text = userProjects[indexPath.row].projectName
        cell.projectAddressLabel.text = userProjects[indexPath.row].projectAddress
        cell.projectBudgetLabel.text = "$" + userProjects[indexPath.row].projectRunningTab
        cell.projectImage.image = userProjects[indexPath.row].projectImage
        
        return cell
    }
    
    // Method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
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
    
    //Called when keyboard is shown
    @objc func keyboardShown(notification: NSNotification) {
        let value = notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject
        let rawFrame = value.cgRectValue
        let keyboardFrame = view.convert(rawFrame!, from: nil)
        
        print(keyboardFrame.height)
        
        
    }
    
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
