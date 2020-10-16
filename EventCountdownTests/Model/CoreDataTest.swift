//
//  EventItemTest.swift
//  EventCountdownTests
//
//  Created by Jerry Hanks on 04/10/2020.
//

import CoreData
@testable import EventCountdown
import XCTest

class CoreDataTest: XCTestCase {
    var persistence: PersistenceController!
    var persistenceContainer: NSPersistentContainer!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        self.persistence = PersistenceController.testing
        self.persistenceContainer = persistence.container
        
        try super.setUpWithError()
    }
    
//    func test_setup_persitenceStoreCreate() throws {
//        let setUpExpectation = expectation(description: "Setup - Store created")
//        
//        try self.persistence.setup {
//            setUpExpectation.fulfill()
//        }
//        
//        //persistence store is lazy loaded so checking it it is nil is not a valid test
//        //so we have to test the count which will result in creating the container and retuning the count.
//        waitForExpectations(timeout: 1.0) { _ in
//            XCTAssert(!self.persistence.container.persistentStoreCoordinator.persistentStores.isEmpty)
//        }
//    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.persistence = nil
        self.persistenceContainer = nil
        
        try super.tearDownWithError()
    }
}
