//
//  ViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit
import SVProgressHUD

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characters = [Character]()
    
    var isFetching = false
    
    var footerView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        loadCharacters()
        initFooterView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCharacters(){
        isFetching = true
        SVProgressHUD.show(withStatus: "Fetching Characters...")
        RestManager.getCharacters(offset: 0) { (characters) in
            self.characters = characters
            self.tableView.reloadData()
            self.isFetching = false
            SVProgressHUD.dismiss()
        }
    }
    
    func loadAdditionalCharacters(offset : Int){
        if !isFetching {
            self.isFetching = true
            RestManager.getCharacters(offset: offset) { (characters) in
                self.characters.append(contentsOf: characters)
                self.tableView.reloadData()
                self.isFetching = false
                let view = self.footerView?.viewWithTag(10) as! UIActivityIndicatorView
                view.startAnimating()
            }
        }
    }
    
    func initFooterView(){
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        
        let activIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        activIndicator.tag = 10
        activIndicator.frame = CGRect(x: 150, y: 5, width: 20, height: 20)
        activIndicator.hidesWhenStopped = true
        
        activIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        footerView?.addSubview(activIndicator)
        
        NSLayoutConstraint(
            item: activIndicator,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        NSLayoutConstraint(
            item: activIndicator,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerY, 
            multiplier: 1.0, 
            constant: 0.0
            ).isActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetail" {
            let vc = segue.destination as! DetailsViewController
            vc.character = sender as! Character?
        }
    }
}

extension CharactersViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCell", for: indexPath) as! CharactersTableViewCell
        
        let character = characters[indexPath.row]
        
        cell.character = character
        
        return cell
    }
}

extension CharactersViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "characterDetail", sender: characters[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isFetching {
            if (self.tableView.contentOffset.y - self.tableView.contentInset.bottom >= self.tableView.contentSize.height - self.tableView.bounds.size.height){
                self.tableView.tableFooterView = footerView
                let view = footerView?.viewWithTag(10) as! UIActivityIndicatorView
                view.startAnimating()
                self.loadAdditionalCharacters(offset: self.characters.count)
            }
        }
    }
}
