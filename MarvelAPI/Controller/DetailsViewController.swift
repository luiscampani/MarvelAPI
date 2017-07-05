//
//  DetailsViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 12/12/16.
//  Copyright © 2016 Luis Filipe Campani. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var characterName: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = self.character{
            self.characterName.text = character.name
            self.characterImage.loadImage( character.thumbnails)
            
            if character.description.isEmpty {
                self.characterDescription.text = character.description
            } else {
                self.characterDescription.text = "No description avaliable"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moreInformationTapped(_ sender: Any) {
        performSegue(withIdentifier: "wiki", sender: nil)
    }
    
    @IBAction func comicsTapped(_ sender: Any) {
        performSegue(withIdentifier: "comics", sender: nil)
    }
    
    @IBAction func seriesTapped(_ sender: Any) {
        performSegue(withIdentifier: "series", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wiki"{
            let vc = segue.destination as! WikiViewController
            if let url = character?.urls["wiki"]{
                vc.url = url
            }
        } else if segue.identifier == "comics" {
            let vc = segue.destination as! ComicsViewController
            if let character = self.character {
                vc.character = character
            }
        } else if segue.identifier == "series" {
            let vc = segue.destination as! SeriesViewController
            if let character = self.character {
                vc.character = character
            }
        }
    }
}
