//
//  LoginViewController.swift
//  MarvelAPI
//
//  Created by Luis Filipe Campani on 7/6/17.
//  Copyright © 2017 Luis Filipe Campani. All rights reserved.
//

import UIKit

import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldSenha: UITextField!
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func conectarButtonTouched(_ sender: Any) {
        if textFieldEmail.text == "" || self.textFieldSenha.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Atenção", message: "Você deve inserir um email e senha.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            SVProgressHUD.show(withStatus: "Conectando...")
            RestManager.login(email: textFieldEmail.text ?? "", senha: textFieldSenha.text ?? "") { result in
                SVProgressHUD.dismiss()
                if result {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showAlert(message: "Ops", title: "Erro Inesperado")
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
            RestManager.cadastro(email: textFieldEmail.text ?? "", senha: textFieldSenha.text ?? "") { result in
                SVProgressHUD.dismiss()
                if result {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showAlert(message: "Ops", title: "Erro Inesperado")
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
