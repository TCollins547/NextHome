//
//  MainViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 1/22/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

var appData = UserAppData()

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchbar: UITextField!
    
    var menuSelectButton0 = UIButton()
    var menuSelectButton1 = UIButton()
    var menuSelectButton2 = UIButton()
    var menuSelectButtons: [UIButton]!
    
    
    @IBOutlet weak var tableView: UITableView!
    var selectedProject: Project!
    
    var blurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var searchAddConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuEdgeConstraint: NSLayoutConstraint!
    
    var newProjectCreationView: NewProjectCreationView!

    /*
    ——————————————— View Controller Methods ———————————————
     Contains: viewDidLoad(), viewWillAppear(Bool), didRecieveMemoryWarning()
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButtons()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Removes navigation bar from top of view to have app full screen
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    ——————————————— Table View Data and Setup ———————————————
     Contains: tableView(numberOfRowsInSection0 -> Int, tableView(cellForRowAt) -> UITableViewCell, tableView(didSelectRowAt)
    */
    
    
    //Returns the amount rows in the project table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Retrieves number of projects user has and adds 1 for creation cell
        
        var tableCount = 0
        
        if titleLabel.text == "My Projects" {
            tableCount = appData.getList("project").count + 1
        } else if titleLabel.text == "My Rooms" {
            tableCount = appData.getList("room").count
        } else {
            tableCount = appData.getList("material").count
        }
        
        return tableCount
    }
    
    // Creates a cell for each table view row
    //Returns created tableviewcell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if titleLabel.text == "My Projects" {
            
            //This places the create new project at the end of the table
            if indexPath.row == appData.getList("project").count {
                
                
                //Creates a cell and a create project view
                let cell: CreateTableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellCreateReuseID") as! CreateTableViewCell?)!
                
                return cell
                
                //Called if not last cell in the table
                //Creates normal project view
            } else {
                
                //Creates a cell and a project view
                let cell: ProjectTableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "ProjectCellReuseID") as! ProjectTableViewCell?)!
                cell.filledCellData(project: appData.getList("project")[indexPath.row] as! Project)
                
                return cell
                
            }
            
        } else if titleLabel.text == "My Rooms" {
            //Setup Room Table view cells
            
            tableView.register(UINib(nibName: "RoomMainViewTableCell", bundle: nil), forCellReuseIdentifier: "roomMainViewReuseID")
            
            let cell: RoomMainViewTableCell = (self.tableView.dequeueReusableCell(withIdentifier: "roomMainViewReuseID") as! RoomMainViewTableCell?)!
            cell.fillCellData(room: appData.getList("room")[indexPath.row] as! Room)
            
            return cell
            
        } else {
            //Setup Material Table view cells
        }
        
        return UITableViewCell()
        
    }
    
    // Method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Handles creation view cells
        if tableView.cellForRow(at: indexPath) is CreateTableViewCell {
            addButtonPressed((Any).self)
            
        //Handles segue to room view
        } else if tableView.cellForRow(at: indexPath) is ProjectTableViewCell {
            selectedProject = ((tableView.cellForRow(at: indexPath) as? ProjectTableViewCell)?.cellProject)!
            performSegue(withIdentifier: "showRoomView", sender: (Any).self)
        }
    }
    
    
    /*
     ——————————————— Menu Button Handling and Setup ———————————————
     Contains: setupMenuButtons(), menuButtonPressed(Any), menuOptionSelected(UIButton)
     */
    
    func setupMenuButtons() {
        
        var menuSelectOptions = ["My Projects", "My Rooms", "My Materials", "Settings"]
        menuSelectButtons = [menuSelectButton0, menuSelectButton1, menuSelectButton2]
        
        for buttonOption in menuSelectButtons {
            
            buttonOption.addTarget(self, action: #selector(menuOptionSelected), for: .touchUpInside)
            buttonOption.frame.size = titleLabel.frame.size
            buttonOption.frame.origin = CGPoint(x: titleLabel.frame.origin.x, y: titleLabel.frame.origin.y + CGFloat(37 * menuSelectButtons.index(of: buttonOption)!))
            buttonOption.setTitle(menuSelectOptions[menuSelectButtons.index(of: buttonOption)! + 1], for: .normal)
            buttonOption.contentHorizontalAlignment = .left
            buttonOption.titleLabel?.font = titleLabel.font
            buttonOption.alpha = 0
            buttonOption.isHidden = true
            self.view.addSubview(buttonOption)
            
        }
        
    }
    
    
    //Handles menu button tap
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        if menuButton.currentBackgroundImage == #imageLiteral(resourceName: "icons8-cancel_filled-1") {
            
            menuButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-xbox_menu_filled"), for: .normal)
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.blurEffectView.alpha = 0
                self.menuSelectButton0.alpha = 0
                self.menuSelectButton1.alpha = 0
                self.menuSelectButton2.alpha = 0
                
            }, completion: { finished in
                self.blurEffectView.isHidden = true
                self.menuSelectButton0.isHidden = true
                self.menuSelectButton1.isHidden = true
                self.menuSelectButton2.isHidden = true
            })
            
        } else {
            
            menuButton.setBackgroundImage(#imageLiteral(resourceName: "icons8-cancel_filled-1"), for: .normal)
            
            blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
            blurEffectView.frame = self.view.bounds
            blurEffectView.alpha = 0
            self.view.addSubview(blurEffectView)

            for menuOption in menuSelectButtons {
                menuOption.isHidden = false
                self.view.bringSubview(toFront: menuOption)
            }
            
            self.view.bringSubview(toFront: titleLabel)
            self.view.bringSubview(toFront: menuButton)
            
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.blurEffectView.alpha = 1
                self.menuSelectButton0.alpha = 1
                self.menuSelectButton1.alpha = 1
                self.menuSelectButton2.alpha = 1
                
            }, completion: nil)
        }
    
    }
    
    @objc func menuOptionSelected(sender: UIButton!) {
        
        var menuSelectOptions = ["My Projects", "My Rooms", "My Materials", "Settings"]
        
        titleLabel.text = sender.titleLabel?.text
        menuSelectOptions = ["My Projects", "My Rooms", "My Materials", "Settings"]
        menuSelectOptions.remove(at: menuSelectOptions.index(of: titleLabel.text!)!)
        menuSelectOptions.insert(titleLabel.text!, at: 0)
        
        for menuOption in menuSelectButtons {
            menuOption.setTitle(menuSelectOptions[menuSelectButtons.index(of: menuOption)! + 1], for: .normal)
        }
        
        menuButtonPressed(self)
        tableView.reloadData()
    }
    
    
    /*
     ——————————————— Project Addition Handling ———————————————
     Contains: addButtonPressed(Any), cancelProjectCreate()
     */
    
    //Handles add button press and also handles search cancel when applicable
    @IBAction func addButtonPressed(_ sender: Any) {
        
        //Triggers when the search is in use
        if !searchbar.isHidden {
            
            self.view.endEditing(true)
            
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
    
    
    /*
     ——————————————— Search Button Setup and Handling ———————————————
     Contains: searchButtonPressed(Any)
     */
    
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
    
    
    /*
     ——————————————— Segue Handling ———————————————
     Contains: prepare(for segue, sender), undwindSegue(sender)
     */
    
    //Handles segues to alternate view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RoomViewController {
            destination.viewProject = selectedProject
        }
    }
    
    @IBAction func undwindSegue(_ sender: UIStoryboardSegue) {
        tableView.reloadData()
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
