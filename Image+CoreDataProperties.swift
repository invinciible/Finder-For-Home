//
//  Image+CoreDataProperties.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 30/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Item?

}
