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
    
    func alerta(titulo: String, mensagem: String){
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Cancelar", style: .cancel)

        alert.addAction(actionOK)
        present(alert, animated: true)
    }
    
    
    @IBAction func entrar(_ sender: Any) {
        //Recuperar dados digitados
        if let email = edtEmail.text {
            if let senha = edtSenha.text {
                
                //autenticar usuario no firebase
                Auth.auth().signIn(withEmail: email, password: senha) { result, erro in
                    if erro == nil {
                        if result?.user == nil {
                            self.alerta(titulo: "Erro ao autenticar", mensagem: "problema ao realizar autenticação, tente novamente!")
                        } else {
                            //Redireciona o usuario para a tela principal
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    } else {
                        self.alerta(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente")
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
