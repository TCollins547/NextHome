//
//  ProjectPhotoCollectionSubView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/6/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ProjectPhotoCollectionSubView: UIView {
    
    @IBOutlet weak var image0: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    var images: [UIImageView] = []
    
    
    override func awakeFromNib() {
        images = [image0, image1, image2, image3, image4, image5]
        self.layer.cornerRadius = 8
    }
    
    func setupImages(project: Project) {
        var imageCount = project.getProjectImages().count
        if imageCount > 5 {
            imageCount = 6
        }
        
        for image in images {
            if images.index(of: image)! < imageCount {
                image.image = project.getProjectImages()[images.index(of: image)!]
            } else if images.index(of: image)! == imageCount {
                image.image = #imageLiteral(resourceName: "icons8-connection_status_off_filled")
            } else {
                image.isHidden = true
            }
        }
        
        
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
