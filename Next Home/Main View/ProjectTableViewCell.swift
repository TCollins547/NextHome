//
//  ProjectTableViewCell.swift
//  Next Home
//
//  Created by Tyler Collins on 2/3/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var projectView: UIView!
    
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var projectAddressLabel: UILabel!
    @IBOutlet weak var projectBudgetLabel: UILabel!
    @IBOutlet weak var projectImage: UIImageView!
    
    var projectID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        projectView.layer.cornerRadius = 8
        
        // Initialization code
    }
    
    func setProjectID(proID: String) {
        projectID = proID
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
