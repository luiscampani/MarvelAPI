//
//  SeriesViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit
import SVProgressHUD

class SeriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var character : Character?{
        didSet{
            if let character = self.character {
                if character.series.count > 0 {
                    self.series = character.series
                } else {
                    self.loadAdditionalSeries(forCharacterId: character.id!, offset: 0)
                }
            }
        }
    }

    var series = [Series]()
    
    var isFetching = false
    var footerView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFooterView()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func loadAdditionalSeries(forCharacterId id : Int, offset : Int){
        if !isFetching {
            self.isFetching = true
            SVProgressHUD.show(withStatus: "Fetching Series...")
            RestManager.getSeriesFromCharacter(characterId: id, offset: offset, response: { (series) in
                for serie in series {
                    self.series.append(serie)
                }
                self.tableView.reloadData()
                self.isFetching = false
                let view = self.footerView?.viewWithTag(10) as! UIActivityIndicatorView
                view.stopAnimating()
                SVProgressHUD.dismiss()
                if self.series.count == 0 {
                    
                }
            })
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
        if segue.identifier == "serieDetail" {
            let vc = segue.destination as! SerieDetailsViewController
            vc.series = sender as! Series?
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
}

extension SeriesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesCell", for: indexPath) as! SeriesTableViewCell
        
        cell.serie = series[indexPath.row]
        
        return cell
    }
}


extension SeriesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "serieDetail", sender: series[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let available = self.character?.seriesAvailable{
            if !isFetching && available > self.series.count{
                if (self.tableView.contentOffset.y - self.tableView.contentInset.bottom >= self.tableView.contentSize.height - self.tableView.bounds.size.height){
                    if let id = self.character?.id {
                        self.tableView.tableFooterView = footerView
                        let view = footerView?.viewWithTag(10) as! UIActivityIndicatorView
                        view.startAnimating()
                        self.loadAdditionalSeries(forCharacterId: id ,offset: self.series.count)
                    }
                }
            }
        }
    }
}
