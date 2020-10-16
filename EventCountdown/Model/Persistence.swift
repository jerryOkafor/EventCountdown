//
//  Persistence.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 02/10/2020.
//

import CoreData

protocol PersistenceController {
    var container: NSPersistentContainer { get }
    func setUp(completion: (() -> Void)?) throws
}

struct CoreDataHelper: PersistenceController {
    let container: NSPersistentContainer
    static let shared = CoreDataHelper()

    //Preview on xcode
    static var preview: PersistenceController = {
        let result = CoreDataHelper(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()

    //Testing
    static var testing: PersistenceController = {
        let result = CoreDataHelper(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "EventCountdown")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            
//            let description = NSPersistentStoreDescription()
//            description.type = NSInMemoryStoreType
//            description.shouldAddStoreAsynchronously = false
//            container.persistentStoreDescriptions = [description]
        }
        
    }
    
    func setUp(completion: (() -> Void)?) throws {
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            completion?()
        }
    }
}
