//
//  ComicSummary.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import SwiftyJSON

class ComicSummary {
    
    var resourceURI : String?
    var name : String?
    
    init(json : JSON){
        if let resourceURI = json["resourceURI"].string {
            self.resourceURI = resourceURI
        }
        if let name = json["name"].string {
            self.name = name
        }
    }
}
