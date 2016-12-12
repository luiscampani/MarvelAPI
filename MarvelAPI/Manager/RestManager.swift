//
//  RestManager.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RestManager {
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 90 // seconds
        configuration.timeoutIntervalForResource = 90
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static let publickey = "03e5549ef0ebfe74bd56db04ba838534"
    static let privatekey = "ee649245c334be6a63eabd184a7ccf7556432342"
    
    static let baseUrl = "https://gateway.marvel.com/v1/public"
    
    static func getCharacters(offset : Int,response: @escaping ([Character])->()){
        
        let getCaractersUrl = baseUrl.appending("/characters")
        
        let timestamp = Date().description
        
        let stringToHash = timestamp.appending(privatekey).appending(publickey)
        
        let hashData = MD5(string: stringToHash)
        let hash : String =  hashData!.map { String(format: "%02hhx", $0) }.joined()
        
        let parameters = ["apikey":publickey,"ts":timestamp,"hash":hash,"limit":100,"offset":offset] as [String : Any]
        
        manager.request(getCaractersUrl, method: .get, parameters: parameters).responseJSON { (request) in
            switch request.result {
            case .success(let value):
                let jsons = JSON(value)
                var characters = [Character]()
                for json in jsons["data"]["results"].array! {
                    characters += [Character(json: json)]
                }
                response(characters)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func MD5(string: String) -> Data? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
}

