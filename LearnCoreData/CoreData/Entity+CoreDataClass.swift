//
//  Entity+CoreDataClass.swift
//  LearnCoreData
//
//  Created by Toan on 6/13/20.
//  Copyright © 2020 Toan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Entity)
public class Entity: NSManagedObject {
    let date1 = Date()
    let formatter = DateFormatter()
}
