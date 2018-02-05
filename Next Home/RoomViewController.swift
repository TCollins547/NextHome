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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
