//
//  MasterViewController.swift
//  JokesNFun
//
//  Created by Devarshi on 5/30/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, CompletionObserver {

    class JokesNFunFeeder {
        
        let atomParser = AtomParser(triggerTag: "entry", parseUrl: "http://feeds2.feedburner.com/jokes-n-fun")
        
        func feedRulesAndStartParsing() {
            
            func feedEndElementRules() {
                // assigning end element(s) mapping rules
                atomParser.endElementRuleMappingDict["published"] = { (recordDict: NSMutableDictionary, tagValue: String) in
                    let obtainedDate = tagValue.getDateFromStringWithAllComponents()
                    recordDict["published"] = obtainedDate?.getDateAndTimeInStringWithShortFormMonthAndTwelveHourFormat()
                }
                atomParser.endElementRuleMappingDict["title"] = { (recordDict: NSMutableDictionary, tagValue: String) in
                    recordDict["title"] = tagValue
                }
                
                atomParser.endElementRuleMappingDict["content"] = { (recordDict: NSMutableDictionary, tagValue: String) in
                    recordDict["content"] = tagValue.getStringBetween("src=\"", endString:"\" ")
                }
                
                atomParser.endElementRuleMappingDict["feedburner:origLink"] = { (recordDict: NSMutableDictionary, tagValue: String) in
                    recordDict["feedburner:origLink"] = tagValue
                }
            }
            
            feedEndElementRules()
            atomParser.startParsing()
            
        }
    }
    
    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    @IBOutlet var datasSourceTable: UITableView!
    let jokesNFunFeeder = JokesNFunFeeder()


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        jokesNFunFeeder.atomParser.completionObserver = self
        jokesNFunFeeder.feedRulesAndStartParsing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as NSDictionary
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.imageUrlString = object["content"] as? String
                controller.currentTitle = object["title"] as? String
                controller.webUrlString = object["feedburner:origLink"] as? String
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dataDict = objects[indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as InfoCell

        cell.titleLabel.text = dataDict["title"] as? String
        cell.dateLabel.text = dataDict["published"] as? String
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowDetail", sender: self)
    }
    
    // MARK: - Reload table on data population
    
    func dataSourcePopulated(dataSourceArray : NSArray) {
        objects.removeAllObjects()
        objects.addObjectsFromArray(dataSourceArray)
        datasSourceTable.reloadData()
    }
    
    
    // MARK: - IBActions
    @IBAction func refreshAction(sender: AnyObject) {
        jokesNFunFeeder.atomParser.startParsing()
    }
}

