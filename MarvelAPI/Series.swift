//
//  Series.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import SwiftyJSON

class Series {
    
    var id : Int?
    var title : String?
    var rating : String?
    var description : String?
    var startYear : Int?
    var endYear : Int?
    var thumbnail : String?
    var seriesCreators = [SerieCreator]()
    
    init(json : JSON){
        if let id = json["id"].int {
            self.id = id
        }
        if let title = json["title"].string {
            self.title = title
        }
        if let rating = json["rating"].string {
            self.rating = rating
        }
        if let description = json["description"].string {
            self.description = description
        }
        if let startYear = json["startYear"].int {
            self.startYear = startYear
        }
        if let endYear = json["endYear"].int {
            self.endYear = endYear
        }
        if let path = json["thumbnail"]["path"].string, let ext = json["thumbnail"]["extension"].string {
            self.thumbnail = path.appending(".").appending(ext)
        }
        if let series = json["creators"]["items"].array {
            for serie in series{
                seriesCreators.append(SerieCreator(json: serie))
            }
        }
    }

}

