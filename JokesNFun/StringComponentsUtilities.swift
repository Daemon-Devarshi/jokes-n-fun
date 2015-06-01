//
//  StringComponentsUtilities.swift
//  JokesNFun
//
//  Created by Devarshi on 5/31/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//

import UIKit

extension String {
    func getStringBetween(startString: String, endString: String) -> String{
        
        // identify first string
        let startStringRange = self.rangeOfString(startString)
        let startIndex = advance(startStringRange!.startIndex, countElements(startString))
        
        // obtain remaining string after first string
        let remainingStringAfterStartIndex = self.substringFromIndex(startIndex)
        
        let endStringRange = remainingStringAfterStartIndex.rangeOfString(endString)
        let endIndex = endStringRange!.startIndex
        
        return remainingStringAfterStartIndex.substringToIndex(endIndex)
    }
}
