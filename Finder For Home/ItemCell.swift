//
//  ItemCell.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 31/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    // reference to cell Items
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var locationDetails: UILabel!
    @IBOutlet weak var mainLocation: UILabel!
    
    // function to set the view at cell 
    func configureCell(item : Item){
        
        name.text = item.name
        locationDetails.text = item.locationDetail
        mainLocation.text = item.location
        thumbImg.image = item.toImage?.image as? UIImage
    }
    
}

