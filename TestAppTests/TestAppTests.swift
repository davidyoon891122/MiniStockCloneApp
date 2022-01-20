//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by iMac on 2022/01/14.
//

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testRandom() {
        var numbers = [1,2,3,4,5,6,7,8,9,0]
        
        
        for _ in 0..<5 {
            guard let randomNumber = numbers.randomElement() else {
                return
            }
            
            numbers.removeAll(where: {$0 == randomNumber})
            
            print("randomNumber: \(randomNumber), result array: \(numbers)")
        }
        
    }
    
    
    func testConvertInt() {
        print(Int("test"))
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
