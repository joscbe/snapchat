//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 26/11/22.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {

    @IBOutlet var edtEmail: UITextField!
    @IBOutlet var edtSenha: UITextField!
    @IBOutlet var edtConfirmaSenha: UITextField!
    
    func alerta(titulo: String, mensagem: String){
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(actionOK)
        present(alert, animated: true)
    }
    
    @IBAction func criarConta(_ sender: Any) {
        let email = edtEmail.text
        let senha = edtSenha.text
        let confirmaSenha = edtConfirmaSenha.text
        
        if senha == confirmaSenha {
            if let email = email {
                if let senha = senha {
                    Auth.auth().createUser(withEmail: email, password: senha) { result, erro in
                        if erro == nil {
                            self.edtEmail.text = ""
                            self.edtSenha.text = ""
                            self.edtConfirmaSenha.text = ""
                            
                            if result?.user == nil {
                                
                            } else {
                                //Redireciona o usuario para a tela principal
                                self.performSegue(withIdentifier: "cadastroSegue", sender: nil)
                            }
                        } else {
                            let erroR = erro! as NSError
                            let ERROR_INVALID_EMAIL = 17008
                            let ERROR_WEAK_PASSWORD = 17026
                            let ERROR_EMAIL_ALREADY_IN_USE = 17007
                            var mensagemError = ""
                            
                            switch erroR.code {
                                case ERROR_INVALID_EMAIL:
                                    mensagemError = "E-mail invalido, digite um e-mail valido!"
                                break
                                case ERROR_WEAK_PASSWORD:
                                    mensagemError = "Senha precisa ter no minimo 6 caracteres, com letras e numeros!"
                                break
                                case ERROR_EMAIL_ALREADY_IN_USE:
                                    mensagemError = "O endereço de e-mail já está sendo usado por outra conta!"
                                break
                            default:
                                mensagemError = "Dados dgitados estão incorretos!"
                            }
                            
                            self.alerta(titulo: "Dados inválidos", mensagem: mensagemError)
                            
                            print(erroR.code)
                        }
                    }
                }
            }
        } else {
            self.alerta(titulo: "Dados incorretos ", mensagem: "As senhas precisão ser iguais")
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
