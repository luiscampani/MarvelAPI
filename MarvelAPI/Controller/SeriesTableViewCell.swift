//
//  SeriesTableViewCell.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    
    var serie : Series?{
        didSet{
            if let serie = self.serie{
                self.itemName.text = serie.title
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
