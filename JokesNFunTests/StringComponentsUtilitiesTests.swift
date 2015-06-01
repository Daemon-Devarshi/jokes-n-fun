//
//  StringComponentsUtilitiesTest.swift
//  JokesNFun
//
//  Created by Devarshi on 5/31/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//

import XCTest

//TODO: Add more useful test cases
class StringComponentsUtilitiesTests : XCTestCase{
    func testGetStringBetweenSrcTags() {
        let completeString = "border=\"0\" src=\"http://3.bp.blogspot.com/-UMKQUhM1Bx4/U0aG6b2ZNxI/AAAAAAAABrA/yxtbTkENNPM/s1600/splashiPhone.jpg\" height=\"320\" "
        
        let shouldBeSubString = "http://3.bp.blogspot.com/-UMKQUhM1Bx4/U0aG6b2ZNxI/AAAAAAAABrA/yxtbTkENNPM/s1600/splashiPhone.jpg"
        
        let subString = completeString.getStringBetween("src=\"", endString: "\" ")
        
        XCTAssertEqual(subString, shouldBeSubString, "Incorrect substring obtained")
        
    }
}