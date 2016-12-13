//
//  Extensions.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import Kingfisher

extension Data {
    func MD5(string: String) -> Data? {
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

extension UIImageView {
    func loadImage(_ url: String){
        let urlToKf = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: urlToKf, placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
}
