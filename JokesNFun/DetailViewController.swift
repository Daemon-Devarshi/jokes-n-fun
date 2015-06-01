//
//  DetailViewController.swift
//  JokesNFun
//
//  Created by Devarshi on 5/30/15.
//  Copyright (c) 2015 Devarshi Kulshreshtha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties driving behaviour if changed
    var imageUrlString : String? {
        didSet {
           // loadImageOnWebView()
        }
    }
    var currentTitle : String? {
        didSet {
          //  self.title = currentTitle
        }
    }

    // MARK: - Normal Properties
    var webUrlString : String?
    @IBOutlet weak var imageDisplayWebView: UIWebView!

    func loadImageOnWebView () {
        let imageUrl = NSURL(string: imageUrlString!)
        imageDisplayWebView.loadRequest(NSURLRequest(URL: imageUrl!))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.loadImageOnWebView()
        self.title = currentTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions
    @IBAction func gotoActualUrl(sender: AnyObject) {
        let webUrl = NSURL(string: webUrlString!)
        UIApplication.sharedApplication().openURL(webUrl!)
    }
    

}

