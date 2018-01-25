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
    
    var projectNames: [String]!
    var projectAddresses: [String]!
    var projectBudgets: [String]!
    var projectImages: [UIImage]!
    
    var blurEffectView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        projectNames = ["West Hills", "Valley", "Coolage", "Arington"]
        projectAddresses = ["23850 West Hills Ln", "98439 Lake View Rd", "59487 Harrington St", "12043 Arington Ct"]
        projectBudgets = ["84,297", "28,297", "83,298", "34,297"]
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectNames.count + 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == projectNames.count {
            
            let cell: ProjectCell = self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellReuseID")! as! ProjectCell
            let newProjectCellView = Bundle.main.loadNibNamed("CreateNewProjectSubView", owner: self, options: nil)?.first as! UIView
            
            newProjectCellView.frame = cell.referenceView.frame
            newProjectCellView.center = cell.referenceView.center
            newProjectCellView.layer.cornerRadius = 8
            
            cell.backgroundColor = UIColor.clear
            cell.contentView.addSubview(newProjectCellView)
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        let cell: ProjectCell = self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellReuseID") as! ProjectCell!
        
        let projectView: ProjectSubView = Bundle.main.loadNibNamed("ProjectSubView", owner: self, options: nil)?.first as! ProjectSubView
        
        projectView.projectNameLabel.text = projectNames[indexPath.row]
        projectView.addressLabel.text = projectAddresses[indexPath.row]
        projectView.budgetLabel.text = "$" + projectBudgets[indexPath.row]
        projectView.projectImage.image = #imageLiteral(resourceName: "Unique-Spanish-Style-House-Colors")
        
        projectView.frame = cell.referenceView.frame
        projectView.center = cell.referenceView.center
        projectView.layer.cornerRadius = 8
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.addSubview(projectView)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    
    @IBAction func menuButtonPressed(_ sender: Any) {
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let newProjectCreationView: NewProjectCreationView = Bundle.main.loadNibNamed("NewProjectCreationView", owner: self, options: nil)?.first as! NewProjectCreationView
        
        newProjectCreationView.projectNameTextField.becomeFirstResponder()
        
        newProjectCreationView.frame = CGRect(x: 10, y: -367, width: Int(self.view.frame.width) - 20, height: 367)
        newProjectCreationView.layer.cornerRadius = 8
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurEffectView.frame = self.view.bounds
        blurEffectView.alpha = 0
        
        self.view.addSubview(blurEffectView)
        self.view.addSubview(newProjectCreationView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blurEffectView.alpha = 1
            newProjectCreationView.frame.origin = CGPoint(x: 10, y: UIApplication.shared.statusBarFrame.height + 10)
            
        }, completion: nil)
        
        
        
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        searchButton.isEnabled = false
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurEffectView.frame = self.view.bounds
        view.addSubview(blurEffectView)
        
        searchbar.alpha = 0
        searchbar.isHidden = true
        blurEffectView.isHidden = true
        blurEffectView.alpha = 0
        
        
        self.view.bringSubview(toFront: searchbar); self.view.bringSubview(toFront: searchButton); self.view.bringSubview(toFront: addButton)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchButton.frame.origin = CGPoint(x: CGFloat(5), y: self.searchButton.frame.origin.y)
            self.addButton.transform = CGAffineTransform(rotationAngle: (45.0 * .pi) / 180.0)
            
            self.searchbar.isHidden = false
            self.searchbar.alpha = 1
            self.blurEffectView.isHidden = false
            self.blurEffectView.alpha = 1
            
        }, completion: nil)
        
    }
    
    @objc func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]! as AnyObject
        
        let rawFrame = value.cgRectValue
        let keyboardFrame = view.convert(rawFrame!, from: nil)
        
        print("keyboardFrame: \(keyboardFrame)")
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
