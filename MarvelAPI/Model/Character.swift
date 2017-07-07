//
//  Character.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import SwiftyJSON

class Character {
    
    let id : Int
    var name : String
    var description : String
    var modified : Date?
    var resourceURI : String
    var urls = [String:String]()
    let thumbnails : String
    let comicsAvailable : Int
    let seriesAvailable : Int
    var comics = [Comics]()
    var series = [Series]()
    
    var selected: Bool = false
    
    init(json : JSON){
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.resourceURI = json["resourceURI"].stringValue
        
        let path = json["thumbnail"]["path"].stringValue
        let ext = json["thumbnail"]["extension"].stringValue
        self.thumbnails = path.appending(".").appending(ext)
        
        self.comicsAvailable = json["comics"]["available"].intValue
        self.seriesAvailable = json["series"]["available"].intValue
        
        for urlObj in json["urls"].arrayValue {
            let type = urlObj["type"].stringValue
            let url = urlObj["url"].stringValue
            self.urls[type] = url
        }
    }
}
