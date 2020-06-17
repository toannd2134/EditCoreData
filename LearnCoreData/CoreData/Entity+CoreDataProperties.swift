//
//  Entity+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by Toan on 6/13/20.
//  Copyright © 2020 Toan. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: String
    @NSManaged public var username: String?
    @NSManaged public var content: String?
    @NSManaged public var date: String?
    @NSManaged public var isSelected: Bool

}
