//
//  ReminderItem+CoreDataProperties.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/18/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//
//

import Foundation
import CoreData


extension ReminderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderItem> {
        return NSFetchRequest<ReminderItem>(entityName: "ReminderItem")
    }

    @NSManaged public var remindAt: Date?
    @NSManaged public var title: String?
    @NSManaged public var des: String?

}
