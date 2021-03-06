//
//  ProjectPhotoCollectionSubView.swift
//  Next Home
//
//  Created by Tyler Collins on 2/6/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class ProjectPhotoCollectionSubView: UIView {
    
    @IBOutlet weak var image0: UIButton!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image3: UIButton!
    @IBOutlet weak var image4: UIButton!
    @IBOutlet weak var image5: UIButton!
    
    var images: [UIButton] = []
    
    var parentView: RoomViewController!
    
    override func awakeFromNib() {
        images = [image0, image1, image2, image3, image4, image5]
        self.layer.cornerRadius = 8
    }
    
    func connectParentView(pView: RoomViewController) {
        parentView = pView
    }
    
    func setupImages(project: Project) {
        
        
        var imageCount = project.getProjectImages().count
        if imageCount > 5 {
            imageCount = 5
        }
        
        if imageCount == 0 {
            image0.setBackgroundImage(#imageLiteral(resourceName: "ViewAllHD"), for: .normal)
            return
        }
        
        for image in images {
            
            image.isHidden = false
            image.layer.cornerRadius = 8
            image.imageView!.contentMode = .scaleAspectFit
            
            if images.index(of: image)! < imageCount {
                image.setBackgroundImage(project.getProjectImages()[images.index(of: image)!], for: .normal)
            } else if images.index(of: image)! == imageCount {
                image.setBackgroundImage(#imageLiteral(resourceName: "ViewAllHD"), for: .normal)
            } else {
                image.isHidden = true
            }
        }
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.currentBackgroundImage == #imageLiteral(resourceName: "ViewAllHD") {
            parentView.performSegue(withIdentifier: "showPhotoCollectionView", sender: (Any).self)
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
