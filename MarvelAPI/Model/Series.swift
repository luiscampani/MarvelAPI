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
    
    var id : Int
    var title : String
    var rating : String
    var description : String
    var startYear : Int
    var endYear : Int
    var thumbnail : String
    var seriesCreators = [SerieCreator]()
    
    init(json : JSON){
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.rating = json["rating"].stringValue
        self.description = json["description"].stringValue
        self.startYear = json["startYear"].intValue
        self.endYear = json["endYear"].intValue
        
        let path = json["thumbnail"]["path"].stringValue
        let ext = json["thumbnail"]["extension"].stringValue
        self.thumbnail = path.appending(".").appending(ext)
        
        self.seriesCreators = json["creators"]["items"].arrayValue.map { SerieCreator(json: $0) }
    }
}

