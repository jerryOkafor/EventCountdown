//
//  XCTestCase+Extension.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 04/10/2020.
//

import Foundation
import XCTest

//https://medium.com/@johnsundell/avoiding-force-unwrapping-in-swift-unit-tests-5c2b9ea64091

extension XCTestCase {
    
    // We conform to LocalizedError in order to be able to output
    // a nice error message.
    private struct RequireError<T>: LocalizedError {
        let file: StaticString
        let line: UInt
        // It's important to implement this property, otherwise we won't
        // get a nice error message in the logs if our tests starts to fail.
        var errorDescription: String? {
            "😱 Required value of type \(T.self) was nil at line \(line) in file \(file)."
        }
    }
    
    // Using file and line lets us automatically capture where
    // the expression took place in our source code.
    func requireNotNil<T>(_ expression: @autoclosure () -> T?, file: StaticString = #file, line: UInt = #line) throws -> T {
        guard let value = expression() else {
            throw RequireError<T>(file: file, line: line)
        }
        return value
    }
}
