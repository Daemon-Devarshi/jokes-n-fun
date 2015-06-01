//
//  StringDateUtilities.swift
//  JokesNFun
//
//  Created by Devarshi on 5/31/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//  Date patterns can be obtained from this link

import UIKit

extension String {
    // to format date from string like : 2014-04-10T22:05:00.001-07:00
    func getDateFromStringWithAllComponents () -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        var returnedDate = dateFormatter.dateFromString(self)
        
        return returnedDate
    }
}
