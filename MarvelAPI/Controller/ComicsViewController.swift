//
//  ComicsViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit
import SVProgressHUD

class ComicsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var character : Character?{
        didSet{
            if let character = self.character {
                if character.comics.count > 0 {
                    self.comics = character.comics
                } else {
                    self.loadAdditionalComics(forCharacterId: character.id, offset: 0)
                }
            }
        }
    }
    
    var comics = [Comics]()
    
    var isFetching = false
    var footerView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFooterView()
        self.tableView.tableFooterView = UIView()
    }
    
    func loadAdditionalComics(forCharacterId id : Int, offset : Int){
        if !isFetching {
            self.isFetching = true
            SVProgressHUD.show(withStatus: "Fetching Comics...")
            RestManager.getComicsFromCharacter(characterId: id, offset: offset, response: { (comics) in
                SVProgressHUD.dismiss()
                guard let comics = comics else {
                    self.showAlert(message: "Não foi possível buscar os dados", title: "Ops")
                    return
                }
                for comic in comics {
                    self.comics.append(comic)
                }
                self.tableView.reloadData()
                self.isFetching = false
                let view = self.footerView?.viewWithTag(10) as! UIActivityIndicatorView
                view.stopAnimating()
                if self.comics.count == 0 {
                    self.initFooterForNoResults()
                }
            })
        }
    }
    
    func initFooterView(){
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        
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
    
    func initFooterForNoResults(){
        let footerWithNoResults = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        let text = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        text.attributedText = NSAttributedString(string: "This character does not have a comic", attributes: [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 17.0)! ])
        text.numberOfLines = 0
        text.textAlignment = .center
        footerWithNoResults.addSubview(text)
        
        NSLayoutConstraint(
            item: text,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: footerWithNoResults,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        NSLayoutConstraint(
            item: text,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: footerWithNoResults,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        self.tableView.tableFooterView = footerWithNoResults
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comicDetail" {
            let vc = segue.destination as! ComicDetailsViewController
            vc.comic = sender as! Comics?
        }
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

extension ComicsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicsCell", for: indexPath) as! ComicsTableViewCell
        
        cell.comic = comics[indexPath.row]
        
        return cell
    }
}


extension ComicsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "comicDetail", sender: comics[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let available = self.character?.comicsAvailable{
            if !isFetching && available > self.comics.count{
                if (self.tableView.contentOffset.y - self.tableView.contentInset.bottom >= self.tableView.contentSize.height - self.tableView.bounds.size.height){
                    if let id = self.character?.id {
                        self.tableView.tableFooterView = footerView
                        let view = footerView?.viewWithTag(10) as! UIActivityIndicatorView
                        view.startAnimating()
                        self.loadAdditionalComics(forCharacterId: id ,offset: self.comics.count)
                    }
                }
            }
        }
    }
}
