//
//  DateStringUtilitiesTests.swift
//  JokesNFun
//
//  Created by Devarshi Kulshreshtha on 01/06/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//

import XCTest

class DateStringUtilitiesTests : XCTestCase{
    func testGetDateAndTimeWithShortFormMonthAndTwelveHourFormat() {
        let currentDate = NSDate()
        let dateString = currentDate.getDateAndTimeInStringWithShortFormMonthAndTwelveHourFormat()
        
        XCTAssertNotNil(dateString, "Date could not be converted to string!")
    }
}
