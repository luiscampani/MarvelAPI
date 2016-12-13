//
//  SeriesDetailsViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit

class SerieDetailsViewController: UIViewController {

    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var seriesDescription: UITextView!
    @IBOutlet weak var seriesCreators: UILabel!
    @IBOutlet weak var seriesRating: UILabel!
    @IBOutlet weak var seriesEndDate: UILabel!
    @IBOutlet weak var seriesStartDate: UILabel!
    
    var series : Series?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let series = self.series {
            if let thumbnail = series.thumbnail {
                print(thumbnail)
                self.seriesImage.loadImage(thumbnail)
            }
            self.seriesName.text = series.title
            if let description = series.description {
                if description != "" {
                    self.seriesDescription.text = description
                }
            } else {
                self.seriesDescription.text = "No description available"
            }
            self.seriesCreators.text = "\(series.seriesCreators.count)"
            if let startYear = self.series?.startYear {
                self.seriesStartDate.text = "\(startYear)"
            }
            if let endYear = self.series?.endYear {
                self.seriesEndDate.text = "\(endYear)"
            }
            if let rating = series.rating {
                if rating != "" {
                    self.seriesRating.text = rating
                } else {
                    self.seriesRating.text = "Not available"
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
