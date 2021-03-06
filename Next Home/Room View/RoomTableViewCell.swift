//
//  RoomTableViewCell.swift
//  Next Home
//
//  Created by Tyler Collins on 2/9/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomBudgetLabel: UILabel!
    @IBOutlet weak var cellContentView: UIView!
    
    var cellRoom: Room!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellContentView.layer.cornerRadius = 8
        
        // Initialization code
    }
    
    func fillCellData(room: Room) {
        cellRoom = room
        
        roomNameLabel.text = cellRoom.roomName
        roomBudgetLabel.text = cellRoom.getRoomTab()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
