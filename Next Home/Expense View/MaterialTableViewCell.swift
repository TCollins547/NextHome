//
//  MaterialTableViewCell.swift
//  Next Home
//
//  Created by Tyler Collins on 3/20/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class MaterialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var materialImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 8
        self.frame.size = CGSize(width: self.frame.width, height: self.frame.width * 0.3)
        
    }
    
    func loadData(_ material: Material) {
        materialImage.image = material.expenseImage
        nameLabel.text = material.name
        costLabel.text = material.getDisplayCost()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
