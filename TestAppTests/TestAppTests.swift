//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by iMac on 2022/01/14.
//

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {
    func test_Random() {
        var numbers = (0..<10).map { $0 }
        
        for _ in 0..<5 {
            guard let randomNumber = numbers.randomElement() else {
                return
            }
            numbers.removeAll(where: {$0 == randomNumber})
        }
        
    }
}
