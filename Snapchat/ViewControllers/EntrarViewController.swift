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
    @IBOutlet var btnEntrar: UIButton!
    
    @IBAction func entrar(_ sender: Any) {
        //Desabilita botão
        buttonEnabled(enabled: false)
        
        //Recuperar dados digitados
        if let email = edtEmail.text {
            if let senha = edtSenha.text {
                
                //autenticar usuario no firebase
                Auth.auth().signIn(withEmail: email, password: senha) { result, erro in
                    if erro == nil {
                        if result?.user == nil {
                            let alerta = Alerta(titulo: "Erro ao autenticar", mensagem: "problema ao realizar autenticação, tente novamente!").getAlerta()
                            self.present(alerta, animated: true)
                            self.buttonEnabled(enabled: true)
                        } else {
                            //Redireciona o usuario para a tela principal
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    } else {
                        let alerta = Alerta(titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente").getAlerta()
                        self.present(alerta, animated: true)
                        self.buttonEnabled(enabled: true)
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
    
    func buttonEnabled(enabled: Bool) {
        if enabled {
            btnEntrar.setTitle("Entrar", for: .normal)
            btnEntrar.isEnabled = true
            btnEntrar.backgroundColor = UIColor(red: 0.686, green: 0.322, blue: 0.871, alpha: 1)
        } else {
            //Desabilita botão
            btnEntrar.setTitle("Carregando...", for: .normal)
            btnEntrar.isEnabled = false
            btnEntrar.backgroundColor = UIColor.gray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
