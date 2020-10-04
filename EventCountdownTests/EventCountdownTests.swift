//
//  EventCountdownTests.swift
//  EventCountdownTests
//
//  Created by Jerry Hanks on 02/10/2020.
//

@testable import EventCountdown
import XCTest

class EventCountdownTests: XCTestCase {
    var persistence: PersistenceController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.persistence = PersistenceController.preview

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.persistence = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
