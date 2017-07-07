//
//  Extensions.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func loadImage(_ url: String){
        let urlToKf = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: urlToKf, placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
}

extension String {
    func removeSpecialChars() -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
        
        return String(self.characters.filter { okayChars.contains($0) })
    }
}
