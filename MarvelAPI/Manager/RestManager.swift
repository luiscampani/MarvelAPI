//
//  RestManager.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseDatabase
import SwiftyJSON

class RestManager {
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static let ref = Database.database().reference(withPath: "favorites")
    
    static let publickey = "03e5549ef0ebfe74bd56db04ba838534"
    static let privatekey = "ee649245c334be6a63eabd184a7ccf7556432342"
    
    static let baseUrl = "https://gateway.marvel.com/v1/public"
    
    static func getCharacters(offset : Int,response: @escaping ([Character])->()){
        
        let getCaractersUrl = baseUrl.appending("/characters")
        let timestamp = Date().description
        let stringToHash = timestamp.appending(privatekey).appending(publickey)
        let hashData = MD5(string: stringToHash)
        let hash =  hashData!.map { String(format: "%02hhx", $0) }.joined()
        
        let parameters = ["apikey":publickey,
                          "ts":timestamp,
                          "hash":hash,
                          "limit":100,
                          "offset":offset] as [String : Any]
        
        manager.request(getCaractersUrl, method: .get, parameters: parameters).responseJSON { (request) in
            switch request.result {
            case .success(let value):
                let json = JSON(value)
                response(json["data"]["results"].arrayValue.map { Character(json: $0) })
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getComicsFromCharacter(characterId : Int , offset : Int, response: @escaping ([Comics])->()){
        var getCaractersComicsUrl = baseUrl.appending("/characters")
        getCaractersComicsUrl.append("/")
        getCaractersComicsUrl.append("\(characterId)")
        getCaractersComicsUrl.append("/comics")
        
        let timestamp = Date().description
        let stringToHash = timestamp.appending(privatekey).appending(publickey)
        let hashData = MD5(string: stringToHash)
        let hash =  hashData!.map { String(format: "%02hhx", $0) }.joined()
        
        let parameters = ["apikey":publickey,
                          "ts":timestamp,
                          "hash":hash,
                          "offset":offset,
                          "limit":100,
                          "orderBy":"title"] as [String : Any]
        
        manager.request(getCaractersComicsUrl, method: .get, parameters: parameters).responseJSON { (request) in
            switch request.result {
            case .success(let value):
                let jsons = JSON(value)
                var comics = [Comics]()
                for json in jsons["data"]["results"].array! {
                    comics.append(Comics(json: json))
                }
                response(comics)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSeriesFromCharacter(characterId : Int , offset : Int, response: @escaping ([Series])->()){
        var getCaractersSeriesUrl = baseUrl.appending("/characters")
        getCaractersSeriesUrl.append("/")
        getCaractersSeriesUrl.append("\(characterId)")
        getCaractersSeriesUrl.append("/series")
        
        let timestamp = Date().description
        let stringToHash = timestamp.appending(privatekey).appending(publickey)
        let hashData = MD5(string: stringToHash)
        
        let hash = hashData!.map { String(format: "%02hhx", $0) }.joined()
        
        let parameters = ["apikey":publickey,
                          "ts":timestamp,
                          "hash":hash,
                          "offset":offset,
                          "limit":100,
                          "orderBy":"title"] as [String : Any]
        
        manager.request(getCaractersSeriesUrl, method: .get, parameters: parameters).responseJSON { (request) in
            switch request.result {
            case .success(let value):
                let jsons = JSON(value)
                var series = [Series]()
                for json in jsons["data"]["results"].array! {
                    series.append(Series(json: json))
                }
                response(series)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func favoriteHero(_ name: String) {
        let reducedName = name.removeSpecialChars()
        let heroItem = Favorite(name: reducedName,
                                addedByUser: Usuario.sharedInstance.uid,
                                completed: false)
        let heroItemRef = self.ref.child(reducedName.lowercased())
        
        heroItemRef.setValue(heroItem.toAnyObject())
    }
    
    static func unfavoriteHero(_ name: String) {
        let reducedName = name.removeSpecialChars()
        
        let heroItem = Favorite(name: reducedName,
                                addedByUser: Usuario.sharedInstance.uid,
                                completed: false)
        heroItem.ref?.removeValue()
    }
    
    static func MD5(string: String) -> Data? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes { digestBytes in
            messageData.withUnsafeBytes { messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
}

