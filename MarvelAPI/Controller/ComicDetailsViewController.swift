//
//  ComicDetailsViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit

class ComicDetailsViewController: UIViewController {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicName: UILabel!
    @IBOutlet weak var comicDescription: UITextView!
    @IBOutlet weak var comicCharacters: UILabel!
    @IBOutlet weak var comicPrice: UILabel!
    
    var comic : Comics?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let comic = self.comic {
            if let thumbnail = comic.thumbnail {
                self.comicImage.loadImage(thumbnail)
            }
            self.comicName.text = comic.title
            if let description = comic.description {
                if description != "" {
                    self.comicDescription.text = description
                }
            } else if let variantDescription = comic.variantDescription {
                if variantDescription != "" {
                    self.comicDescription.text = variantDescription
                }
            } else {
                self.comicDescription.text = "No description available"
            }
            for character in comic.comicCharacters {
                if let name = character.name {
                    self.comicCharacters.text = self.comicCharacters.text?.appending("  \(name)")
                }
            }
            if comic.prices.count != 0 {
                if let printPrice = comic.prices["printPrice"] {
                    self.comicPrice.text = "$\(printPrice)"
                } else if let digitalPrice = comic.prices["digitalPrice"] {
                    self.comicPrice.text = "$\(digitalPrice)"
                }
            } else {
                self.comicPrice.text = "Not available"
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
