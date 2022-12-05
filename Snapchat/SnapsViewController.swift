//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 03/12/22.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    @IBAction func sair(_ sender: Any) {
        //Deslogar usuario
        do {
            try Auth.auth().signOut()
            //Fecha a tela
            dismiss(animated: true)
        } catch {
            print("Erro ao deslogar usuario")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
