//
//  RoomMainViewTableCell.swift
//  Next Home
//
//  Created by Tyler Collins on 2/10/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class RoomMainViewTableCell: UITableViewCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomProjectLabel: UILabel!
    @IBOutlet weak var roomBudgetLabel: UILabel!
    
    @IBOutlet weak var cellContentArea: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor.clear
        cellContentArea.layer.cornerRadius = 8
        selectionStyle = .none
        
        // Initialization code
    }
    
    func fillCellData(room: Room) {
        
        roomNameLabel.text = room.roomName
        roomProjectLabel.text = room.roomProject.projectName //+ " - " + room.roomType
        roomBudgetLabel.text = "$" + room.getRoomTab()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
