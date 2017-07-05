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
    
    let resourceURI: [String]
    let name: String
    let role: String
    
    init(json : JSON){
        self.resourceURI = json["resourceURI"].arrayValue.map { $0.stringValue }
        self.name = json["name"].stringValue
        self.role = json["role"].stringValue
        
    }
}
