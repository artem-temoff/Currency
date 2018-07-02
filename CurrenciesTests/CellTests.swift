//
//  CellTests.swift
//  CurrenciesTests
//
//  Created by Eremenko on 02/07/2018.
//  Copyright © 2018 company. All rights reserved.
//

import XCTest
@testable import Currencies

class CellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialization() {
        let cell = CurrencyCell(style: .default, reuseIdentifier: "cell")
        XCTAssertNotNil(cell.img)
        XCTAssertNotNil(cell.title)
        XCTAssertNotNil(cell.subtitle)
        XCTAssertNotNil(cell.value)
    }
}
