//
//  PhotoCollectionViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 2/7/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var zoomedImageView: UIImageView!
    @IBOutlet var deletePhotoButton: UIButton!
    @IBOutlet var closeZoomedViewButton: UIButton!
    var blurEffectView: UIVisualEffectView!
    
    var viewProject: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        if viewProject != nil {
            projectNameLabel.text = viewProject.projectName + " Album"
        } else {
            projectNameLabel.text = "Data Error"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: Int(self.view.frame.width - 40) / 3, height: Int(self.view.frame.width - 40) / 3)
        photoCollectionView.collectionViewLayout = layout
        photoCollectionView.backgroundColor = UIColor.clear
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        zoomedImageView = UIImageView()
        zoomedImageView.contentMode = .scaleAspectFit
        zoomedImageView.frame = CGRect(x: 16, y: self.view.frame.height * -1, width: self.view.frame.width - 32, height: self.view.frame.height - 50)
        zoomedImageView.image = (photoCollectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell).cellImageView.image
        zoomedImageView.isHidden = false
        
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurEffectView.frame = self.view.bounds
        blurEffectView.alpha = 0
        
        deletePhotoButton.alpha = 0
        deletePhotoButton.isHidden = false
        closeZoomedViewButton.alpha = 0
        closeZoomedViewButton.isHidden = false
        
        self.view.addSubview(blurEffectView)
        self.view.addSubview(zoomedImageView)
        self.view.bringSubview(toFront: deletePhotoButton)
        self.view.bringSubview(toFront: closeZoomedViewButton)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.blurEffectView.alpha = 1
            self.zoomedImageView.frame.origin = CGPoint(x: 16, y: UIApplication.shared.statusBarFrame.height + 10)
            self.deletePhotoButton.alpha = 1
            self.closeZoomedViewButton.alpha = 1
            
        }, completion: nil)
        
    }
    
    @IBAction func closeZoomedViewButtonPressed(sender: UIButton!) {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.blurEffectView.alpha = 0
            self.zoomedImageView.frame.origin = CGPoint(x: 16, y: self.view.frame.height * -1)
            self.deletePhotoButton.alpha = 0
            self.closeZoomedViewButton.alpha = 0
            
        }, completion: { finished in
            self.blurEffectView.removeFromSuperview()
            self.zoomedImageView.removeFromSuperview()
            self.closeZoomedViewButton.isHidden = true
            self.deletePhotoButton.isHidden = true
        })
        
    }
    
    @IBAction func deletePhotoButtonPressed(sender: UIButton!) {
        
        viewProject.removeProjectImage(removedImage: zoomedImageView.image!)
        photoCollectionView.reloadData()
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.blurEffectView.alpha = 0
            self.zoomedImageView.alpha = 0
            self.deletePhotoButton.alpha = 0
            self.closeZoomedViewButton.alpha = 0
            
        }, completion: { finished in
            self.blurEffectView.removeFromSuperview()
            self.zoomedImageView.removeFromSuperview()
            self.closeZoomedViewButton.isHidden = true
            self.deletePhotoButton.isHidden = true
        })
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewProject.projectImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionProjectImageCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.cellImageView.image = viewProject.projectImages[viewProject.projectImages.count - indexPath.row - 1]
        
        return cell
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewProject.addProjectImage(addedImage: image)
            photoCollectionView.reloadData()
        } else {
            //Write error message
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
