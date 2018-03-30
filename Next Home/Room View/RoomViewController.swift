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
    
    var projectImagesView: ProjectPhotoCollectionSubView!
    var projectDetailsView: ProjectDetailSubView!
    
    var viewProject: Project!
    var projectRooms: [Room]!
    
    var selectedRoom: Room!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewProject != nil {
            projectRooms = userData.loadInRooms(forRoomIDs: viewProject.roomsID)
            viewProject.rooms = projectRooms
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
        return projectRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoomTableViewCell = (self.roomTableView.dequeueReusableCell(withIdentifier: "RoomCellReuseID") as! RoomTableViewCell?)!
        cell.fillCellData(room: projectRooms[indexPath.row])
        cell.frame.size = CGSize(width: self.view.frame.width, height: 75)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoom = (tableView.cellForRow(at: indexPath) as! RoomTableViewCell).cellRoom
        performSegue(withIdentifier: "roomToExpenseSegue", sender: self)
    }
    
    func editInfoButtonPressed() {
        
        performSegue(withIdentifier: "showCreationView", sender: self)
        
    }
    
    func refreshView() {
        projectNameLabel.text = viewProject.projectName
        projectAddressLabel.text = viewProject.projectAddress
        projectTabLabel.text = viewProject.getRunningTab()
        setupScrollViews()
    }
    
    @IBAction func undwindToRoom(_ sender: UIStoryboardSegue) {
        if sender.source is RoomCreationView {
            projectRooms = userData.loadInRooms(forRoomIDs: viewProject.roomsID)
            roomTableView.reloadData()
        } else if sender.source is ProjectCreationView {
            projectDetailsView.setupValues(project: viewProject)
        } else if sender.source is PhotoCollectionViewController {
            print("Setting new images")
            projectImagesView.setupImages(project: viewProject)
        } else if sender.source is ExpenseViewController {
            viewProject.calcValues()
            refreshView()
            roomTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoCollectionViewController {
            destination.viewProject = self.viewProject
        } else if let destination = segue.destination as? ExpenseViewController {
            destination.viewRoom = self.selectedRoom
            selectedRoom.roomProject = viewProject
        } else if let destination = segue.destination as? ProjectCreationView {
            destination.viewProject = self.viewProject
        } else if let desination = segue.destination as? RoomCreationView {
            desination.viewProject = self.viewProject
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
