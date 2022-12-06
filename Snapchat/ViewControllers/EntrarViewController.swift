//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 26/11/22.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {

    @IBOutlet var edtEmail: UITextField!
    @IBOutlet var edtSenha: UITextField!
    
    @IBAction func entrar(_ sender: Any) {
        //Recuperar dados digitados
        if let email = edtEmail.text {
            if let senha = edtSenha.text {
                
                //autenticar usuario no firebase
                Auth.auth().signIn(withEmail: email, password: senha) { result, erro in
                    if erro == nil {
                        if result?.user == nil {
                            let alerta = Alerta(titulo: "Erro ao autenticar", mensagem: "problema ao realizar autenticação, tente novamente!").getAlerta()
                            self.present(alerta, animated: true)
                        } else {
                            //Redireciona o usuario para a tela principal
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    } else {
                        let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente").getAlerta()
                        self.present(alerta, animated: true)
                    }
                }
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
