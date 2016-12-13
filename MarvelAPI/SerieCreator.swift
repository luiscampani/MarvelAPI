//
//  SerieSummary.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import SwiftyJSON

class SerieCreator {
    
    var resourceURI : [String]?
    var name : String?
    var role : String?
    
    init(json : JSON){
        if let resources = json["resourceURI"].array {
            
            for resource in resources {
                self.resourceURI?.append(resource.string!)
            }
        }
        if let name = json["name"].string {
            self.name = name
        }
        if let role = json["role"].string {
            self.role = role
        }
    }
}
