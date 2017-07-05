//
//  Comic.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import SwiftyJSON

class Comics {
    
    let id : Int
    let digitalId : Int
    let title : String
    let variantDescription : String
    let description : String
    let format : String
    let pageCount : Int
    var prices = [String:Float]()
    let thumbnail : String
    let comicCharacters: [ComicCharacter]
    
    init(json : JSON) {
        self.id = json["id"].intValue
        self.digitalId = json["digitalId"].intValue
        self.title = json["title"].stringValue
        self.variantDescription = json["variantDescription"].stringValue
        self.description = json["description"].stringValue
        self.format = json["format"].stringValue
        self.pageCount = json["pageCount"].intValue
        
        for priceObj in json["prices"].arrayValue {
            let type = priceObj["type"].stringValue
            let price = priceObj["price"].floatValue
            self.prices[type] = price
        }
        
        let path = json["thumbnail"]["path"].stringValue
        let ext = json["thumbnail"]["extension"].stringValue
        self.thumbnail = path.appending(".").appending(ext)
        self.comicCharacters = json["characters"]["items"].arrayValue.map { ComicCharacter(json: $0) }
    }
}

