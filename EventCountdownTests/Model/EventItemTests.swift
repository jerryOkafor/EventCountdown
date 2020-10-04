//
//  EventItemTests.swift
//  EventCountdownTests
//
//  Created by Jerry Hanks on 04/10/2020.
//

import CoreData
@testable import EventCountdown
import XCTest

class EventItemTests: XCTestCase {
    var persistence: PersistenceController!
    var persistenceContainer: NSPersistentContainer!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.persistence = PersistenceController.testing
        try self.persistence.setup(completion: nil)
        
        self.persistenceContainer = persistence.container
        
        try super.setUpWithError()
    }
    
    
    func testAddItem() throws {
//        try self.persistence.setup(completion: nil)
        let context = self.persistenceContainer.newBackgroundContext()

        let id = UUID()
        let newItem = Item(context: context)
        newItem.id = id
        newItem.timestamp = Date()
        try context.save()
//        let viewContext = self.persistenceContainer.viewContext
        let fetchReqquest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchReqquest.fetchLimit = 1
        fetchReqquest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        let items = try context.fetch(fetchReqquest)

        let  fetchedItem = try requireNotNil(items.first as? NSManagedObject)
        XCTAssertEqual(fetchedItem.value(forKey: "id") as? UUID, id)
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.persistence = nil
        self.persistenceContainer = nil
        
        try super.tearDownWithError()
    }
    
}
