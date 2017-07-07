//
//  LoginViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 7/6/17.
//  Copyright © 2017 Luis Filipe Campani. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldSenha: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func conectarButtonTouched(_ sender: Any) {
        if textFieldEmail.text == "" || self.textFieldEmail.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Atenção", message: "Você deve inserir um email e senha.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            SVProgressHUD.show(withStatus: "Conectando...")
            Auth.auth().signIn(withEmail: (textFieldEmail.text ?? ""), password: textFieldSenha.text ?? "") { (user, error) in
                SVProgressHUD.dismiss()
                if error == nil {
                    Usuario.sharedInstance.uid = user?.uid ?? ""
                    Usuario.sharedInstance.email = user?.email ?? ""
                    
                    self.navigationController?.popViewController(animated: true)
                    
                } else {
                    let alertController = UIAlertController(title: "Ops", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func registrarButtonTouched(_ sender: Any) {
        if textFieldEmail.text == "" {
            let alertController = UIAlertController(title: "Atenção", message: "Você deve inserir um email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            SVProgressHUD.show(withStatus: "Registrando...")
            Auth.auth().createUser(withEmail: (textFieldEmail.text ?? ""), password: (textFieldSenha.text ?? "")) { (user, error) in
                SVProgressHUD.dismiss()
                if error == nil {
                    Usuario.sharedInstance.uid = user?.uid ?? ""
                    Usuario.sharedInstance.email = user?.email ?? ""
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
