//
//  MaterialDetailViewController.swift
//  Next Home
//
//  Created by Tyler Collins on 3/23/18.
//  Copyright © 2018 Tyler Collins. All rights reserved.
//

import UIKit

class MaterialDetailViewController: UIViewController {
    
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var materialNameLabel: UILabel!
    
    var costHeader = UILabel()
    var vendorHeader = UILabel()
    var addInfoHeader = UILabel()
    
    var totalCostNameLabel = UILabel()
    var totalCostLabel = UILabel()
    
    var costPerUnitNameLabel = UILabel()
    var costPerUnitLabel = UILabel()
    
    var percentBudgetNameLabel = UILabel()
    var percentBudgetlabel = UILabel()
    
    var boughtNameLabel = UILabel()
    var boughtLabel = UILabel()
    
    var usedNameLabel = UILabel()
    var usedLabel = UILabel()
    
    var storeNameLabel = UILabel()
    var storeLabel = UILabel()
    
    var phoneNameLabel = UILabel()
    var phoneLabel = UILabel()
    
    var websiteNameLabel = UILabel()
    var websiteLabel = UILabel()
    
    var notesNameLabel = UILabel()
    var notesLabel = UILabel()
    
    var imageLabel = UILabel()
    var materialImage = UIImageView()
    
    var reciptLabel = UILabel()
    var reciptImage = UIImageView()
    
    var editButton = UIButton()
    var deleteButton = UIButton()
    
    var viewMaterial: Material!
    var viewRoom: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard viewMaterial != nil && viewRoom != nil else {
            performSegue(withIdentifier: "undwindToMaterial", sender: self)
            return
        }
        
        materialNameLabel.text = viewMaterial.name
        
        setupLabels()
        setupImages()
        setupButtons()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLabels() {
        
        let headers = [costHeader, vendorHeader, addInfoHeader]
        let nameLabels = [totalCostNameLabel, costPerUnitNameLabel, percentBudgetNameLabel, boughtNameLabel, usedNameLabel, storeNameLabel, phoneNameLabel, websiteNameLabel, notesNameLabel]
        let labels = [totalCostLabel, costPerUnitLabel, costPerUnitLabel, percentBudgetlabel, boughtLabel, usedLabel, storeLabel, phoneLabel, websiteLabel, notesLabel]
        
        for header in headers {
            header.frame.size = CGSize(width: self.view.frame.width, height: 25)
            header.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 20)
            header.textColor = UIColor.white
            detailsScrollView.addSubview(header)
        }
        
        for label in nameLabels {
            label.frame.size = CGSize(width: self.view.frame.width - 15, height: 25)
            label.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 20)
            label.textColor = UIColor.white
            detailsScrollView.addSubview(label)
        }
        
        for label in labels {
            label.frame.size = CGSize(width: self.view.frame.width - 25, height: 30)
            label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
            label.textColor = UIColor.white
            detailsScrollView.addSubview(label)
        }
        
        
        costHeader.frame.origin = CGPoint(x: 0, y: 0)
        costHeader.backgroundColor = UIColor.green
        costHeader.textAlignment = .center
        costHeader.text = "Cost Information"
        
        totalCostNameLabel.frame.origin = CGPoint(x: 15, y: Int(costHeader.frame.origin.y) + 35)
        totalCostNameLabel.text = "Total Cost:"
        
        totalCostLabel.frame.origin = CGPoint(x: 25, y: Int(totalCostNameLabel.frame.origin.y) + 30)
        totalCostLabel.text = viewMaterial.getDisplayCost()
        
        
        costPerUnitNameLabel.frame.origin = CGPoint(x: 15, y: Int(totalCostLabel.frame.origin.y) + 40)
        costPerUnitNameLabel.text = "Cost Per Unit:"
        
        costPerUnitLabel.frame.origin = CGPoint(x: 25, y: Int(costPerUnitNameLabel.frame.origin.y) + 30)
        costPerUnitLabel.text = viewMaterial.getDisplayUnitCost() + "/" + viewMaterial.unit
        
        
        percentBudgetNameLabel.frame.origin = CGPoint(x: 15, y: Int(costPerUnitLabel.frame.origin.y) + 40)
        percentBudgetNameLabel.text = "Percent of Room Budget:"
        
        percentBudgetlabel.frame.origin = CGPoint(x: 25, y: Int(percentBudgetNameLabel.frame.origin.y) + 30)
        percentBudgetlabel.text = UserData.formatDollars((viewMaterial.totalCost / Double(viewRoom.roomBudget)) * 100).replacingOccurrences(of: "$", with: "") + "%"
        
        
//        boughtNameLabel.frame.origin = CGPoint(x: 15, y: Int(percentBudgetlabel.frame.origin.y) + 40)
//        boughtNameLabel.text = "Units Bought:"
//
//        boughtLabel.frame.origin = CGPoint(x: 25, y: Int(boughtNameLabel.frame.origin.y) + 30)
//        boughtLabel.text = String(Int(viewMaterial.unitsBought)) + " " + viewMaterial.unit
        
        
        usedNameLabel.frame.origin = CGPoint(x: 15, y: Int(percentBudgetlabel.frame.origin.y) + 40)
        usedNameLabel.text = "Units Used:"
        
        usedLabel.frame.origin = CGPoint(x: 25, y: Int(usedNameLabel.frame.origin.y) + 30)
        usedLabel.text = String(Int(viewMaterial.unitsUsed)) + " " + viewMaterial.unit + " of " + String(Int(viewMaterial.unitsBought)) + " " + viewMaterial.unit
        
        
        
        vendorHeader.frame.origin = CGPoint(x: 0, y: Int(usedLabel.frame.origin.y) + 40)
        vendorHeader.backgroundColor = UIColor.blue
        vendorHeader.textAlignment = .center
        vendorHeader.text = "Vendor Information"
        
        
        storeNameLabel.frame.origin = CGPoint(x: 15, y: Int(vendorHeader.frame.origin.y) + 35)
        storeNameLabel.text = "Store:"
        
        storeLabel.frame.origin = CGPoint(x: 25, y: Int(storeNameLabel.frame.origin.y) + 30)
        storeLabel.frame.size = CGSize(width: self.view.frame.width - 25, height: 60)
        storeLabel.numberOfLines = 2
        storeLabel.text = "\(viewMaterial.boughtFromStoreName!)\n\(viewMaterial.boughtFromStoreAddress!)"
        
        
        phoneNameLabel.frame.origin = CGPoint(x: 15, y: Int(storeLabel.frame.origin.y) + 70)
        phoneNameLabel.text = "Phone Number:"
        
        phoneLabel.frame.origin = CGPoint(x: 25, y: Int(phoneNameLabel.frame.origin.y) + 30)
        phoneLabel.text = viewMaterial.boughtFromPhone
        
        
        websiteNameLabel.frame.origin = CGPoint(x: 15, y: Int(phoneLabel.frame.origin.y) + 40)
        websiteNameLabel.text = "Website:"
        
        websiteLabel.frame.origin = CGPoint(x: 25, y: Int(websiteNameLabel.frame.origin.y) + 30)
        websiteLabel.text = viewMaterial.boughtFromWebsite
        
        
        
        addInfoHeader.frame.origin = CGPoint(x: 0, y: Int(websiteLabel.frame.origin.y) + 40)
        addInfoHeader.backgroundColor = UIColor.red
        addInfoHeader.textAlignment = .center
        addInfoHeader.text = "Additional Information"
        
        
        notesNameLabel.frame.origin = CGPoint(x: 15, y: Int(addInfoHeader.frame.origin.y) + 35)
        notesNameLabel.text = "Notes:"
        
        notesLabel.frame.origin = CGPoint(x: 25, y: Int(notesNameLabel.frame.origin.y) + 30)
        notesLabel.frame.size = CGSize(width: Int(self.view.frame.width) - 40, height: Int(heightForView(text: viewMaterial.note, font: UIFont(name: "AppleSDGothicNeo-Bold", size: 25)!, width: self.view.frame.width - 40)))
        notesLabel.lineBreakMode = .byCharWrapping
        notesLabel.numberOfLines = 0
        notesLabel.text = viewMaterial.note
        
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func setupImages() {
        
        materialImage.frame = CGRect(x: 25, y: Int(notesLabel.frame.origin.y + notesLabel.frame.height) + 20, width: Int(self.view.frame.width) - 50, height: Int(self.view.frame.height) / 5)
        materialImage.image = viewMaterial.expenseImage
        materialImage.contentMode = .scaleAspectFill
        materialImage.clipsToBounds = true
        detailsScrollView.addSubview(materialImage)
        
        reciptImage.frame = CGRect(x: 25, y: Int(materialImage.frame.origin.y + materialImage.frame.height) + 20, width: Int(self.view.frame.width) - 50, height: Int(self.view.frame.height) / 5)
        reciptImage.image = viewMaterial.reciptImage
        reciptImage.contentMode = .scaleAspectFill
        reciptImage.clipsToBounds = true
        detailsScrollView.addSubview(reciptImage)
        
    }
    
    func setupButtons() {
        
        editButton.frame = CGRect(x: 0, y: Int(reciptImage.frame.origin.y + reciptImage.frame.height) + 20, width: Int(self.view.frame.width), height: 50)
        editButton.setTitle("Edit Material", for: .normal)
        editButton.backgroundColor = UIColor(red: 121/255, green: 165/255, blue: 230/255, alpha: 1)
        editButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        editButton.titleLabel?.textColor = UIColor.white
        editButton.addTarget(self, action: #selector(self.editButtonTapped), for: .touchUpInside)
        detailsScrollView.addSubview(editButton)
        
        deleteButton.frame = CGRect(x: 0, y: Int(editButton.frame.origin.y + editButton.frame.height) + 20, width: Int(self.view.frame.width), height: 50)
        deleteButton.setTitle("Delete Material", for: .normal)
        deleteButton.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1)
        deleteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        deleteButton.titleLabel?.textColor = UIColor.white
        deleteButton.addTarget(self, action: #selector(self.deleteButtonTapped), for: .touchUpInside)
        detailsScrollView.addSubview(deleteButton)
        
        detailsScrollView.contentSize = CGSize(width: Int(self.view.frame.width), height: Int(deleteButton.frame.origin.y + deleteButton.frame.height) + 20)
        
    }
    
    @objc func editButtonTapped() {
        
    }
    
    @objc func deleteButtonTapped() {
        
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
