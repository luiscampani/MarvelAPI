//
//  ComicSummary.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import SwiftyJSON

class ComicCharacter {
    
    var resourceURI : String
    var name : String
    
    init(json : JSON){
        resourceURI = json["resourceURI"].stringValue
        name = json["name"].stringValue
    }
}
