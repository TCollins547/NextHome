//
//  RoomViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 2/4/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectAddressLabel: UILabel!
    @IBOutlet weak var projectTabLabel: UILabel!
    
    @IBOutlet weak var roomTableView: UITableView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    var projectID = String()
    var viewProject: Project!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for project in MainViewController.UserItems.userProjects {
            if project.projectIdentifier == projectID {
                viewProject = project
                break
            }
        }
        
        if viewProject != nil {
            projectNameLabel.text = viewProject.projectName
            projectAddressLabel.text = viewProject.projectAddress
            projectTabLabel.text = "$" + viewProject.projectRunningTab
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
        
        let projectDetailsView = Bundle.main.loadNibNamed("ProjectDetailSubView", owner: self, options: nil)?.first as! ProjectDetailSubView
        projectDetailsView.setupValues(project: viewProject)
        projectDetailsView.frame = CGRect(x: detailScrollView.contentOffset.x + 10, y: detailScrollView.contentOffset.y + 10, width: detailScrollView.frame.width - 20, height: detailScrollView.frame.height - 20)
        detailScrollView.addSubview(projectDetailsView)
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addRoomButtonPressed(_ sender: Any) {
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
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
