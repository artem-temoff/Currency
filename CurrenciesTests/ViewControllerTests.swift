//
//  ViewControllerTests.swift
//  CurrenciesTests
//
//  Created by Eremenko on 02/07/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import XCTest
@testable import Currencies

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "viewController") as? ViewController
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        super.tearDown()
    }
    
    func test() {
        XCTAssertNotNil(viewController)
    
    }
    
}
