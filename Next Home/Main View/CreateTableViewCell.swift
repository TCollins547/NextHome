//
//  CreateTableViewCell.swift
//  Next Home
//
//  Created by Tyler Collins on 2/3/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class CreateTableViewCell: UITableViewCell {

    @IBOutlet weak var createView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Adds corner radius and selection style
        self.selectionStyle = .none
        self.createView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
