//
//  AtomParser.swift
//  Romeo
//
//  Created by Devarshi on 5/19/15.
//  Copyright (c) 2015 Gotcha. All rights reserved.
//

import UIKit

// MARK: - declaring typealias to store closures with dictionary
typealias StartTagRuleBlock = (NSMutableDictionary, [NSObject : AnyObject]) -> Void
typealias EndTagRuleBlock = (NSMutableDictionary, String) -> Void

// MARK: - Protocol implemented
protocol CompletionObserver {
    func dataSourcePopulated(dataSourceArray : NSArray) -> ()
}

class AtomParser : NSObject, NSXMLParserDelegate {
    // MARK: - Properties
    let triggerTag : String
    let parseUrl : String
    
    var dataArray : NSMutableArray = NSMutableArray()
    
    var collectedCharacters : NSMutableString?
    var recordDict : NSMutableDictionary?
    var parser : NSXMLParser?
    var startElementRuleMappingDict:[String: StartTagRuleBlock] = [String: StartTagRuleBlock]()
    var endElementRuleMappingDict:[String: EndTagRuleBlock] = [String: EndTagRuleBlock]()
    var endTagRules : NSDictionary?

    var completionObserver : CompletionObserver?
    
    // MARK: - Designated initializer
    /**
    Designated initializer to initialize AtomParser class.
    
    :param: triggerTag     Tag which distinguishes each record.
    :param: parseUrl       URL supplying xml to be parser.
    
    :returns: Void.
    */
    init(triggerTag : String, parseUrl : String) {
        self.triggerTag = triggerTag
        self.parseUrl = parseUrl
    }
    
    // MARK: - Initiate parsing
    func startParsing () {
        let url = NSURL(string: self.parseUrl)
        parser = NSXMLParser(contentsOfURL: url)
        parser?.delegate = self
        parser?.parse()
    }
    
    // MARK: - Parser delegates
    func parserDidStartDocument(parser: NSXMLParser!) {
        self.dataArray.removeAllObjects()
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        if elementName == triggerTag {
            recordDict = NSMutableDictionary(capacity: 1)
        }
        else if recordDict != nil {
            if let startTagMappingElement = self.startElementRuleMappingDict[elementName] {
                startTagMappingElement(recordDict!,attributeDict)
            }
            
            collectedCharacters = NSMutableString(string: "")
            
        }
        else {
            // no need to handle these tags
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        collectedCharacters?.appendString(string)
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if let mutableDictionary = recordDict {
            if elementName == triggerTag {
                dataArray.addObject(recordDict!)
            }
            else if recordDict != nil {
                if let endTagMappingElement = self.endElementRuleMappingDict[elementName] {
                    endTagMappingElement(recordDict!,"\(String(collectedCharacters!))")  
                }
            }
            else {
                // no need to handle these tags
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        let arrayToReturn = NSArray(array: dataArray)
        completionObserver?.dataSourcePopulated(arrayToReturn)
    }
}
