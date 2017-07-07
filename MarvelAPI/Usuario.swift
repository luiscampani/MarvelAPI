//
//  Usuario.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 7/6/17.
//  Copyright © 2017 Luis Filipe Campani. All rights reserved.
//

import Foundation

class Usuario {
    static let sharedInstance = Usuario()
    
    var uid: String = ""
    var email: String = ""
}
