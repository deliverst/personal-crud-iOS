//
//  HomeViewController.swift
//  utchProyect
//
//  Created by deliverst on 06/09/21.
//

import UIKit
import FirebaseAuth
import FirebaseRemoteConfig
//import FirebaseCrashlitycs
import FirebaseFirestore

enum ProviderType: String {
    case basic
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var providerLabal: UILabel!
    @IBOutlet weak var colseSesionButton: UIButton!
    
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
        
    private let email: String
    private let provider: ProviderType
    
    private let db = Firestore.firestore()
    
    init(email: String,provider: ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not be implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Inicio"
        emailLabel.text = email
        providerLabal.text = provider.rawValue
    }
    
    @IBAction func closeSesionButtonAction(_ sender: Any) {
        switch provider {
            case .basic:
                do {
                    try Auth.auth().signOut()
                    navigationController?.popViewController(animated: true)
                } catch {
                    // se ha producido un errror
                }
        }
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        db.collection("users").document(email).setData([
            "provider" : provider.rawValue,
            "address":addressTextField.text ?? "",
            "phone":phoneTextField.text ?? "",
        ])
        view.endEditing(true)
    }
    @IBAction func getButtonAction(_ sender: Any) {
        view.endEditing(true)
//        lamaremos a la instancia a la base de datos y al documento llamado mail
        db.collection("users").document(email).getDocument {
            (documentSnapshot, error) in
            
//            si el documento es dinstinto de nullo incluso el error es nulo, significa que acabamos de recuperrar datos
            if let document = documentSnapshot, error == nil {
//                llamando al documento y a get pasandole el nombre del campo que queremos recuperar por ejemplo la direccion y en caso de que exista la direccion  y sea un campos de tipo string, y llamamos y asosiarle el valor que habemos recuperado
                if let address = document.get("address") as? String {
                    self.addressTextField.text = address
                }
                
//                y recuperamos los valores de telefono tambien como la vez pasada
                if let phone = document.get("phone") as? String {
                    self.phoneTextField.text = phone
                }
            }
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        db.collection("users").document(email).delete()
        view.endEditing(true)
    }
}
