//
//  ProjectDetailSubView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/5/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ProjectDetailSubView: UIView {

    @IBOutlet weak var projectBudgetLabel: UILabel!
    @IBOutlet weak var projectRemainingBudgetLabel: UILabel!
    @IBOutlet weak var projectValueLabel: UILabel!
    @IBOutlet weak var projectStartDateLabel: UILabel!
    @IBOutlet weak var projectEndDateLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
    }
    
    func setupValues(project: Project) {
        projectBudgetLabel.text = "$" + project.projectBudget
        projectRemainingBudgetLabel.text = "$" + project.projectRemainingBudget
        projectValueLabel.text = "$" + project.projectExpectedValue
        projectStartDateLabel.text = project.projectStartDate
        projectEndDateLabel.text = project.projectExpectedEndDate
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
