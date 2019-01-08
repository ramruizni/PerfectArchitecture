//
//  MainViewModelTests.swift
//  PerfectArchitectureTests
//
//  Created by valid on 1/8/19.
//  Copyright © 2019 valid. All rights reserved.
//

import XCTest
@testable import PerfectArchitecture

class MainViewModelTests: XCTestCase {
    
    func testElementsToDisplay() {
        let elements = [
            Element("1", "First element", true),
            Element("2", "Second element", false),
            Element("3", "Third element", true),
            Element("4", "Fourth element", false),
            Element("5", "Fifth element", true)
        ]
        
        let mainViewModel = MainViewModel()
        
        let firstResult = mainViewModel.elementsToDisplay(elements, true, "1")
        
        XCTAssert(firstResult.count == 1)
        XCTAssert(firstResult[0].name == "1")
        XCTAssert(firstResult[0].description == "First element")
        XCTAssert(firstResult[0].isFavorite == true)
    }
    
}
