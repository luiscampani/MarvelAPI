//
//  ComicsTableViewCell.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemName: UILabel!
    
    var comic : Comics?{
        didSet{
            if let comic = self.comic{
                self.itemName.text = comic.title
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
