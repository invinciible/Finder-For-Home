//
//  ItemAddVC.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 31/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class ItemAddVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    @IBOutlet weak var ItemName: UITextField!
    
    @IBOutlet weak var itemLocation: UITextField!
    
    @IBOutlet weak var itemLocationDetails: UITextField!
    
    @IBOutlet weak var ItemImg: UIImageView!
   
    var imagePicker : UIImagePickerController!
    var ItemToEdit : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() // to hide keyboard when click anywhere on uiview
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain
                , target: nil, action: nil)
            // changing of the back button text
        }
        
        if ItemToEdit != nil {
            loadItemData()
        }
        
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        
        var item : Item!
        let picture = Image(context: context)
        
        picture.image = ItemImg.image
        
        
        if ItemToEdit == nil {
            
            item = Item(context: context)
        }
        else {
            item = ItemToEdit
        }
        
        item.toImage = picture
        
        if let name = ItemName.text {
            
            item.name = name
        }
        
        if let location = itemLocation.text {
            
            item.location = location
        }
        
        if let locationDetails = itemLocationDetails.text {
            
            item.locationDetail = locationDetails
        }
        ad.saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    func loadItemData(){
        
     if let item = ItemToEdit {
        
        ItemName.text = item.name
        itemLocation.text = item.location
        itemLocationDetails.text = item.locationDetail
        ItemImg.image = item.toImage?.image as? UIImage
        }
        
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIBarButtonItem) {
        
        if ItemToEdit != nil {
            
            context.delete(ItemToEdit!)
            
            ad.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            ItemImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imagePickerBtnPressed(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
   
}
