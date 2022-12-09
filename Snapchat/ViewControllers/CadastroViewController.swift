//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 26/11/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: UIViewController {

    @IBOutlet var edtEmail: UITextField!
    @IBOutlet var edtNomeCompleto: UITextField!
    @IBOutlet var edtSenha: UITextField!
    @IBOutlet var edtConfirmaSenha: UITextField!
    @IBOutlet var btnCriarConta: UIButton!
    
    
    @IBAction func criarConta(_ sender: Any) {
        enabledButton(enabled: false)
        
        let email = edtEmail.text
        let senha = edtSenha.text
        let nomeCompleto = edtNomeCompleto.text
        let confirmaSenha = edtConfirmaSenha.text
        
        let validateError = validateRegistration(email: email, nomeComleto: nomeCompleto, senha: senha, confirmarSenha: confirmaSenha)
        
        
        if validateError == nil {
            if let email = email {
                if let nomeCompleto = nomeCompleto {
                    if let senha = senha {
                        Auth.auth().createUser(withEmail: email, password: senha) { result, erro in
                            if erro == nil {
                                self.edtEmail.text = ""
                                self.edtSenha.text = ""
                                self.edtConfirmaSenha.text = ""
                                self.edtNomeCompleto.text = ""
                                
                                if let user = result?.user {
                                    let database = Database.database().reference()
                                    let usuarios = database.child("usuarios")
                                    
                                    let usuarioDados = ["nome": nomeCompleto, "email": email]
                                    
                                    usuarios.child(user.uid).setValue(usuarioDados)
                                    
                                    self.enabledButton(enabled: true)
                                    //Redireciona o usuario para a tela principal
                                    self.performSegue(withIdentifier: "cadastroSegue", sender: nil)
                                } else {
                                    let alert = Alerta(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticação, tente novamente!").getAlerta()
                                    self.present(alert, animated: true)
                                    self.enabledButton(enabled: true)
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
                                
                                let alerta = Alerta(titulo: "Dados inválidos", mensagem: mensagemError).getAlerta()
                                self.present(alerta, animated: true)
                                //print(erroR.code)
                                self.enabledButton(enabled: true)
                            }
                        }
                    }
                }
            }
        } else {
            let mensagemErro = validateError!
            
            let alerta = Alerta(titulo: "Dados incorretos", mensagem: mensagemErro).getAlerta()
            self.present(alerta, animated: true)
            self.enabledButton(enabled: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func enabledButton(enabled: Bool) {
        if enabled {
            self.btnCriarConta.isEnabled = enabled
            self.btnCriarConta.setTitle("Criar Conta", for: .normal)
        } else {
            self.btnCriarConta.isEnabled = enabled
            self.btnCriarConta.setTitle("Carregando...", for: .normal)
        }
    }
    
    func validateRegistration(email: String?, nomeComleto: String?, senha: String?, confirmarSenha: String?) -> String?{
        if senha != confirmarSenha {
            return "Senha precisão ser iguais!"
        }
        
        if nomeComleto == "" {
            return "Digite o seu nome para proseguir!"
        }
        
        return nil
    }

}
