//
//  CharactersTableViewCell.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIButton!
    
    var character: Character? {
        didSet{
            if let character = self.character {
                self.characterName.text = character.name
                let thumbnail = character.thumbnails
                self.characterImage.loadImage(thumbnail)
                
                favoriteImage.isHidden = Usuario.sharedInstance.uid.isEmpty ? true : false
            }
        }
    }
    
    @IBAction func favoriteHero(_ sender: Any) {
        if favoriteImage.isSelected {
            RestManager.unfavoriteHero(characterName.text ?? "")
        } else {
            RestManager.favoriteHero(characterName.text ?? "")
        }
        favoriteImage.isSelected = !favoriteImage.isSelected
    }
}
