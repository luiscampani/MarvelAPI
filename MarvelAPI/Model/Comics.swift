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
 
    var id : Int?
    var digitalId : Int?
    var title : String?
    var variantDescription : String?
    var description : String?
    var format : String?
    var pageCount : Int?
    var price : Int?
    var thumbnail : String?
    var comicCharacters = [ComicCharacter]()
    
    init(json : JSON){
        if let id = json["id"].int {
            self.id = id
        }
        if let digitalId = json["digitalId"].int {
            self.digitalId = digitalId
        }
        if let title = json["title"].string {
            self.title = title
        }
        if let variantDescription = json["variantDescription"].string {
            self.variantDescription = variantDescription
        }
        if let description = json["description"].string {
            self.description = description
        }
        if let format = json["format"].string {
            self.format = format
        }
        if let pageCount = json["pageCount"].int {
            self.pageCount = pageCount
        }
        if let prices = json["prices"]["price"].int {
            self.price = prices
        }
        if let path = json["thumbnail"]["path"].string, let ext = json["thumbnail"]["extension"].string {
            self.thumbnail = path.appending(".").appending(ext)
        }
        if let characters = json["characters"]["items"].array {
            for character in characters{
                comicCharacters.append(ComicCharacter(json: character))
            }
        }
    }
}
