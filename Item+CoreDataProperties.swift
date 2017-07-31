//
//  Item+CoreDataProperties.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 30/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var locationDetail: String?
    @NSManaged public var createdOn: NSDate?
    @NSManaged public var toImage: Image?

}
