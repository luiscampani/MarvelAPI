//
//  WikiViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = self.url{
            let request = NSURLRequest(url: URL(string: url)!)
            
            webView.loadRequest(request as URLRequest)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
