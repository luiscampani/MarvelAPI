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
        initActivityIndicator()
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
    
    func initActivityIndicator(){
        let activIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        activIndicator.tag = 10
        activIndicator.frame = CGRect(x: 150, y: 5, width: 20, height: 20)
        activIndicator.hidesWhenStopped = true
        
        activIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        self.webView?.addSubview(activIndicator)
        
        NSLayoutConstraint(
            item: activIndicator,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.webView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        NSLayoutConstraint(
            item: activIndicator,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self.webView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
    }
}

extension WikiViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        let view = self.webView.viewWithTag(10) as! UIActivityIndicatorView
        view.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let view = self.webView.viewWithTag(10) as! UIActivityIndicatorView
        view.stopAnimating()
    }
}
