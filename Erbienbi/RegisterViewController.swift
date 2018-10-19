//
//  RegisterViewController.swift
//  Erbienbi
//
//  Created by Armando Herrera on 10/18/18.
//  Copyright © 2018 juan.enriquez. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (result, error) in
            if error == nil && result != nil {
                print("User created")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
}
