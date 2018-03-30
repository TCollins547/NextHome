//
//  MaterialViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 2/10/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var runningTabLabel: UILabel!
    
    @IBOutlet weak var expenseTableView: UITableView!
    
    
    var viewRoom: Room!
    var selectedExpense: Expense!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewHeader()

        // Do any additional setup after loading the view.
    }
    
    func loadViewHeader() {
        if viewRoom != nil {
            roomNameLabel.text = viewRoom.roomName
            countLabel.text = "\(viewRoom.roomExpensesID.count) Expenses"
            runningTabLabel.text = viewRoom.getRoomTab()
            viewRoom.roomExpenses = userData.loadInExpenses(forExpenseIDs: viewRoom.roomExpensesID)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewRoom.getExpenseCount() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.row == 0 {
            cell = (self.expenseTableView.dequeueReusableCell(withIdentifier: "detailCellReuseID") as! RoomDetailTableViewCell?)!
            (cell as! RoomDetailTableViewCell).connectParentView(self)
            (cell as! RoomDetailTableViewCell).setValues(room: viewRoom)
        } else {
            if viewRoom.roomExpenses[indexPath.row - 1] is Material {
                cell = (self.expenseTableView.dequeueReusableCell(withIdentifier: "materialCellReuseID") as! MaterialTableViewCell?)!
                (cell as! MaterialTableViewCell).loadData(viewRoom.roomExpenses[indexPath.row - 1] as! Material)
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            selectedExpense = viewRoom.roomExpenses[indexPath.row - 1]
            performSegue(withIdentifier: "segueToMaterialDetail", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: "What kind of expense?", message: nil, preferredStyle: .actionSheet)
        
        let materialOption = UIAlertAction(title: "Material", style: .default, handler: { action in
            self.performSegue(withIdentifier: "showMaterialCreationView", sender: self)
        })
        
        let serviceOption = UIAlertAction(title: "Service", style: .default, handler: { action in
            self.performSegue(withIdentifier: "showServiceCreationView", sender: self)
        })
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenu.addAction(materialOption); optionMenu.addAction(serviceOption); optionMenu.addAction(cancelOption)
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RoomCreationView {
            destination.viewRoom = self.viewRoom
            destination.viewProject = viewRoom.roomProject
        } else if let destination = segue.destination as? ExpenseCreationView {
            destination.viewRoom = self.viewRoom
            if segue.identifier == "showMaterialCreationView" {
                destination.expenseType = "Material"
            } else {
                destination.expenseType = "Service"
            }
        } else if let destination = segue.destination as? MaterialDetailViewController {
            destination.viewMaterial = selectedExpense as! Material
            destination.viewRoom = self.viewRoom!
        }
    }
    
    @IBAction func undwindToMaterial(_ segue: UIStoryboardSegue) {
        loadViewHeader()
        expenseTableView.reloadData()
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
