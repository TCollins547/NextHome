//
//  MaterialViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 2/10/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class MaterialViewController: UIViewController {

    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    
    var viewRoom: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewRoom != nil {
            roomNameLabel.text = viewRoom.roomName
            areaNameLabel.text = viewRoom.roomType
            budgetLabel.text = "$" + viewRoom.getRoomTab()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        
        
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
