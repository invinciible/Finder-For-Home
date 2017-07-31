//
//  Item+CoreDataClass.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 30/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.createdOn = NSDate() // Assigning the current date to the attribute createdOn when any new item will be created
    }
}
