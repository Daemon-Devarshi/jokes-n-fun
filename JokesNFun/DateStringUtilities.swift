//
//  DateStringUtilities.swift
//  JokesNFun
//
//  Created by Devarshi Kulshreshtha on 01/06/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//

import UIKit

extension NSDate {
    // MARK: - Sample date - 04 Aug'15 12:30 PM
    func getDateAndTimeInStringWithShortFormMonthAndTwelveHourFormat() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM''yy hh:mm a"
        let dateToReturn = dateFormatter.stringFromDate(self)
        return dateToReturn
    }
}
