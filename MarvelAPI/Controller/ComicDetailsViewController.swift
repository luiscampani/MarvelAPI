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
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupComic() {
        guard let comic = self.comic else { return }
        
        comicImage.loadImage(comic.thumbnail)
        comicName.text = comic.title
        comicDescription.text = getComicDescription(comic)
        
        for character in comic.comicCharacters {
            let name = character.name
            self.comicCharacters.text = self.comicCharacters.text?.appending("  \(name)")
        }
        
        comicPrice.text = getComicPrice(comic)
    }
    
    private func getComicDescription(_ comic: Comics) -> String {
        if comic.description.isEmpty {
            return comic.description
        }
        else if comic.variantDescription.isEmpty {
            return  comic.variantDescription
        }
        return "No description available"
    }
    
    private func getComicPrice(_ comic: Comics) -> String {
        if comic.prices.count != 0 {
            if let printPrice = comic.prices["printPrice"] {
                return "$\(printPrice)"
            } else if let digitalPrice = comic.prices["digitalPrice"] {
                return "$\(digitalPrice)"
            }
        }
        
        return "Not available"
    }
}
