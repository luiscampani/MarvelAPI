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
    
    var character: Character?{
        didSet{
            if let character = self.character{
                self.characterName.text = character.name
                if let thumbnail = character.thumbnails {
                    self.characterImage.loadImage(thumbnail)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
