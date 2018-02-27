//
//  RoomViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 2/4/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectAddressLabel: UILabel!
    @IBOutlet weak var projectTabLabel: UILabel!
    
    @IBOutlet weak var roomTableView: UITableView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    var blurEffectView: UIVisualEffectView!
    var newProjectCreationView: NewProjectCreationView!
    
    var projectImagesView: ProjectPhotoCollectionSubView!
    var projectDetailsView: ProjectDetailSubView!
    
    var newRoomCreationView: NewRoomCreationView!
    
    var viewProject: Project!
    var projectRooms: [Room]!
    
    var selectedRoom: Room!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewProject != nil {
            projectRooms = viewProject.rooms
            projectNameLabel.text = viewProject.projectName
            projectAddressLabel.text = viewProject.projectAddress
            projectTabLabel.text = viewProject.getRunningTab()
        } else {
            projectNameLabel.text = "Data error"
            projectAddressLabel.text = "Data error"
            projectTabLabel.text = "Data error"
        }
        
        setupScrollViews()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func setupScrollViews() {
        
        detailScrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(2), height: detailScrollView.frame.height)
        
        for subView in detailScrollView.subviews {
            subView.removeFromSuperview()
        }
        
        projectImagesView = Bundle.main.loadNibNamed("ProjectPhotoCollectionSubView", owner: self, options: nil)?.first as! ProjectPhotoCollectionSubView
        projectImagesView.connectParentView(pView: self)
        projectImagesView.setupImages(project: viewProject)
        projectImagesView.frame = CGRect(x: detailScrollView.contentOffset.x + 10 + self.view.frame.width, y: detailScrollView.contentOffset.y + 10, width: detailScrollView.frame.width - 20, height: detailScrollView.frame.height - 20)
        detailScrollView.addSubview(projectImagesView)
        
        projectDetailsView = Bundle.main.loadNibNamed("ProjectDetailSubView", owner: self, options: nil)?.first as! ProjectDetailSubView
        projectDetailsView.connectParentView(pView: self)
        projectDetailsView.setupValues(project: viewProject)
        projectDetailsView.frame = CGRect(x: detailScrollView.contentOffset.x + 10, y: detailScrollView.contentOffset.y + 10, width: detailScrollView.frame.width - 20, height: detailScrollView.frame.height - 20)
        detailScrollView.addSubview(projectDetailsView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewProject.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoomTableViewCell = (self.roomTableView.dequeueReusableCell(withIdentifier: "RoomCellReuseID") as! RoomTableViewCell?)!
        cell.fillCellData(room: viewProject.rooms[indexPath.row])
        cell.frame.size = CGSize(width: self.view.frame.width, height: 75)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoom = (tableView.cellForRow(at: indexPath) as! RoomTableViewCell).cellRoom
        performSegue(withIdentifier: "roomToMaterialSegue", sender: self)
    }
    
    @IBAction func addRoomButtonPressed(_ sender: Any) {
        
        newRoomCreationView = Bundle.main.loadNibNamed("NewRoomCreationView", owner: self, options: nil)?.first as! NewRoomCreationView
        newRoomCreationView.frame = CGRect(x: 10, y: self.view.frame.height * -1, width: self.view.frame.width - 20, height: newRoomCreationView.frame.height)
        newRoomCreationView.connectParentView(pView: self, project: viewProject)
        newRoomCreationView.roomAreaTextField.becomeFirstResponder()
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurEffectView.frame = self.view.bounds
        blurEffectView.alpha = 0
        
        self.view.addSubview(blurEffectView)
        self.view.addSubview(newRoomCreationView)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.blurEffectView.alpha = 1
            self.newRoomCreationView.frame.origin = CGPoint(x: 10, y: UIApplication.shared.statusBarFrame.height + 10)
            
        }, completion: nil)
        
    }
    
    func editInfoButtonPressed() {
        
        performSegue(withIdentifier: "showCreationView", sender: self)
        
    }
    
    func cancelProjectEdit() {
        
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.newProjectCreationView.frame.origin = CGPoint(x: self.newProjectCreationView.frame.origin.x, y: self.newProjectCreationView.frame.height * -1)
            self.blurEffectView.alpha = 0
            
        }, completion: { finished in
            self.newProjectCreationView.isHidden = true
            self.blurEffectView.isHidden = true
        })
        
    }
    
    func refreshView() {
        projectNameLabel.text = viewProject.projectName
        projectAddressLabel.text = viewProject.projectAddress
        projectTabLabel.text = viewProject.getRunningTab()
        setupScrollViews()
    }
    
    @IBAction func undwindToRoom(_ sender: UIStoryboardSegue) {
        self.viewDidLoad()
        projectImagesView.setupImages(project: viewProject)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoCollectionViewController {
            destination.viewProject = self.viewProject
        } else if let destination = segue.destination as? MaterialViewController {
            destination.viewRoom = self.selectedRoom
        } else if let destination = segue.destination as? ProjectCreationViewController {
            destination.viewProject = self.viewProject
        }
    }
    
    func cancelRoomCreate() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.newRoomCreationView.frame.origin = CGPoint(x: self.newRoomCreationView.frame.origin.x, y: self.view.frame.height * -1)
            self.blurEffectView.alpha = 0
            
        }, completion: { finished in
            self.newRoomCreationView.isHidden = true
            self.blurEffectView.isHidden = true
        })
        
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
