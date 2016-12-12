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
    
    var available : Int?
    var returned : Int?
    var collectionURI : String?
    var items = [SeriesSummary]()
    
    init(json : JSON){
        if let collectionURI = json["collectionURI"].string {
            self.collectionURI = collectionURI
        }
        if let available = json["available"].int {
            self.available = available
        }
        if let returned = json["returned"].int {
            self.returned = returned
        }
        if let items = json["items"].array {
            for item in items {
                self.items.append(SeriesSummary(json: item))
            }
        }
    }
}

