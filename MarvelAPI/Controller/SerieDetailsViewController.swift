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
            
            self.seriesImage.loadImage(series.thumbnail)
            
            self.seriesName.text = series.title
            
            if series.description != "" {
                self.seriesDescription.text = series.description
            }
            else {
                self.seriesDescription.text = "No description available"
            }
            self.seriesCreators.text = "\(series.seriesCreators.count)"
            self.seriesStartDate.text = "\(series.startYear)"
            self.seriesEndDate.text = "\(series.endYear)"
            
            if series.rating != "" {
                self.seriesRating.text = series.rating
            } else {
                self.seriesRating.text = "Not available"
            }
        }
    }
}
