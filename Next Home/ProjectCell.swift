//
//  ProjectCell.swift
//  Next Home
//
//  Created by Tyler Collins on 1/22/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

@IBDesignable class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var referenceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        // Initialization code
    }
    
    func setupProjectSubView(cellProject: Project) {
        let projectView = referenceView as! ProjectSubView
        projectView.budgetLabel.text = "$" + cellProject.projectRunningTab
        projectView.projectNameLabel.text = cellProject.projectName
        projectView.addressLabel.text = cellProject.projectAddress
        projectView.projectImage.image = cellProject.projectImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        // Configure the view for the selected state
    }

}
