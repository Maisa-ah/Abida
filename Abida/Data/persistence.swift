//
//  persistence.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/18/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import Foundation
import CoreData

class persistence{
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AbidaData")
        container.loadPersistentStores { (storeDescription, error)
            in
            if let error = error {
                fatalError("Could not load data store: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("you did it!")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
