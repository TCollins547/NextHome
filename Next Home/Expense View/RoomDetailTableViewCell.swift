//
//  RoomDetailTableViewCell.swift
//  Next Home
//
//  Created by Tyler Collins on 2/28/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class RoomDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var roomBudgetLabel: UILabel!
    @IBOutlet weak var remainingBudgetLabel: UILabel!
    
    @IBOutlet weak var materialCountLabel: UILabel!
    @IBOutlet weak var serviceCountLabel: UILabel!
    
    @IBOutlet weak var editInfoButton: UIButton!
    @IBOutlet weak var viewPhotosButton: UIButton!
    
    var parentView: ExpenseViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 8
        editInfoButton.layer.cornerRadius = 8
        viewPhotosButton.layer.cornerRadius = 8
        
    }
    
    func setValues(room: Room) {
        roomBudgetLabel.text = room.getRoomBudget()
        remainingBudgetLabel.text = room.getRoomRemaining()
        materialCountLabel.text = "\(room.getMaterialCount()) Materials"
        serviceCountLabel.text = "\(room.getServiceCount) Services"
    }
    
    func connectParentView(_ parent: ExpenseViewController) {
        parentView = parent
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func editInfoButtonPressed(_ sender: Any) {
        parentView.performSegue(withIdentifier: "showRoomCreationView", sender: parentView)
    }
    
}
