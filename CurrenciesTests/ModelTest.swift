//
//  ModelTest.swift
//  CurrenciesTests
//
//  Created by Eremenko on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import Currencies

class ModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let obj = ["AUD": 1.5684,
                   "BGN": 1.9507,
                   "BRL": 4.4036,
                   "CAD": 1.5402,
                   "CHF": 1.1506,
                   "CNY": 7.6448,
                   "CZK": 25.709,
                   "DKK": 7.4311,
                   "GBP": 0.87941,
                   "HKD": 9.0919,
                   "HRK": 7.3612,
                   "HUF": 325.94,
                   "IDR": 16441,
                   "ILS": 4.2242,
                   "INR": 79.485,
                   "ISK": 124.07,
                   "JPY": 127.74,
                   "KRW": 1295.5,
                   "MXN": 23.121,
                   "MYR": 4.6672,
                   "NOK": 9.4536,
                   "NZD": 1.7001,
                   "PHP": 61.994,
                   "PLN": 4.3249,
                   "RON": 4.6431,
                   "RUB": 73.166,
                   "SEK": 10.323,
                   "SGD": 1.5792,
                   "THB": 38.232,
                   "TRY": 5.3559,
                   "USD": 1.1585,
                   "ZAR": 15.853]
        let jsonDictionary : [String: Any] = ["base":"EUR",
                    "date":"2018-06-27",
                    "rates":obj]
        let wrongJson : [String: Any] = ["base":"EUR",
                                         "date":"2018-06-27",
                                         "rates":1]
        let result : CurrencyResponse? = Mapper<CurrencyResponse>().map(JSON: jsonDictionary)
        let wrongresult : CurrencyResponse? = Mapper<CurrencyResponse>().map(JSON: wrongJson)
        XCTAssertNotNil(result)
        XCTAssertNil(wrongresult)
        XCTAssertEqual(result?.base, jsonDictionary["base"] as? String)
        XCTAssertEqual(result?.date, jsonDictionary["date"] as? String)
        XCTAssertEqual(result?.rates.count, obj.count)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
