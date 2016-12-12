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
            if let thumbnail = character.thumbnails {
                self.characterImage.loadImage(thumbnail)
            }
            if character.description != ""{
                self.characterDescription.text = character.description
            } else {
                self.characterDescription.text = "No description avaliable"
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moreInformationTapped(_ sender: Any) {
        performSegue(withIdentifier: "wiki", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wiki"{
            let vc = segue.destination as! WikiViewController
            if let url = character?.urls["wiki"]{
                vc.url = url
            }
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
}
