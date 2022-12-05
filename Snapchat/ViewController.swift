//
//  ViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 26/11/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if let usuario = user {
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
                //let vc = SnapsViewController()
               // self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


}

