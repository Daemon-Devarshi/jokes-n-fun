//
//  StringDateUtilitiesTests.swift
//  JokesNFun
//
//  Created by Devarshi on 5/31/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//

import XCTest

//TODO: Add more useful test cases
class StringDateUtilitiesTests: XCTestCase {
    func testGetDateFromStringWithAllComponentsNonNilCheck () {
        let dateString = "2014-04-10T22:05:00.001-07:00"
        let convertedDate = dateString.getDateFromStringWithAllComponents()
        
        XCTAssertNotNil(convertedDate, "String could not be converted to date")
    }
}
