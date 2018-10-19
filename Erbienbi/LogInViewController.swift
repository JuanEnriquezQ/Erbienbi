//
//  LogInViewController.swift
//  Erbienbi
//
//  Created by Armando Herrera on 10/18/18.
//  Copyright © 2018 juan.enriquez. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInbuttonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (result, error) in
            if error == nil && result != nil {
                print("User signed in")
                self.showHomeScree()
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }

    func showHomeScree(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeScreen")
        self.present(controller, animated: true, completion: nil)
    }
}
