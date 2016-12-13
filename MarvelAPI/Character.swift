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
    
    var id : Int?
    var name : String?
    var description : String?
    var modified : Date?
    var resourceURI : String?
    var urls = [String:String]()
    var thumbnails : String?
    var comicsAvailable : Int?
    var seriesAvailable : Int?
    var comics = [Comics]()
    var series = [Series]()
    
    init(json : JSON){
        if let id = json["id"].int {
            self.id = id
        }
        if let name = json["name"].string {
            self.name = name
        }
        if let description = json["description"].string {
            self.description = description
        }
        if let resource = json["resourceURI"].string {
            self.resourceURI = resource
        }
        if let path = json["thumbnail"]["path"].string, let ext = json["thumbnail"]["extension"].string {
            self.thumbnails = path.appending(".").appending(ext)
        }
        if let available = json["comics"]["available"].int{
            self.comicsAvailable = available
        }
        if let available = json["series"]["available"].int{
            self.seriesAvailable = available
        }
        if let urls = json["urls"].array{
            for urlObj in urls{
                if let type = urlObj["type"].string, let url = urlObj["url"].string{
                    self.urls[type] = url
                }
            }
        }
    }
}

