//
//  ViewModelTests.swift
//  CurrenciesTests
//
//  Created by Eremenko on 02/07/2018.
//  Copyright © 2018 company. All rights reserved.
//

import XCTest
@testable import Currencies

class ViewModelTests: XCTestCase {
    
    var vm : ViewModel?
    
    override func setUp() {
        super.setUp()
        vm = ViewModel()
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertNotNil(vm, "The view model should not be nil.")
        
    }
    
}
