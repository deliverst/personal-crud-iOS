//
//  AuthViewController.swift
//  utchProyect
//
//  Created by deliverst on 06/09/21.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Autenticación"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func singUpButtonAction(_ sender: Any) {
        if let email = emailTextField.text,
           let passwords = passswordTextField.text{
            Auth.auth().createUser(withEmail: email, password: passwords) {
                (result, error) in
                if let result = result, error == nil{
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                    
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al registrar el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        if let email = emailTextField.text,
           let passwords = passswordTextField.text{
            Auth.auth().signIn(withEmail: email, password: passwords) {
                (result, error) in
                if let result = result, error == nil{
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                    
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al registrar el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
}
