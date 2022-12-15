//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 12/12/22.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetalhesSnapViewController: UIViewController {

    @IBOutlet var imagem: UIImageView!
    @IBOutlet var detalhesLabel: UILabel!
    @IBOutlet var contadorLabel: UILabel!
    
    var snap: Snap?
    var tempo = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detalhesLabel.text = "Carregando..."

        if let snap = snap {
            let urlImagem = URL(string: snap.urlImagem)
            
            imagem.sd_setImage(with: urlImagem) { uiImagem, erro, cache, url in
                if erro == nil{
                    self.detalhesLabel.text = snap.descricao
                    
                    //Inicia o contador
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        //Exibir timer na tela
                        self.contadorLabel.text = String(self.tempo)
                        
                        //Caso o timer execute até zero, invalidate
                        if self.tempo == 0 {
                            timer.invalidate()
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        
                        //Decrementar timer
                        self.tempo -= 1
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let uidUsuarioLogado = Auth.auth().currentUser?.uid {
            if let snap = snap {
                //Remove snap do database
                let database = Database.database().reference()
                let usuarios = database.child("usuarios")
                let snaps = usuarios.child(uidUsuarioLogado).child("snaps")
                
                snaps.child(snap.id).removeValue()
                
                //Remove a imagem do snap
                let storage = Storage.storage().reference()
                let imagens = storage.child("imagens")
                
                
                imagens.child("\(snap.idImagem).jpg").delete { erro in
                    if erro == nil {
                        print("Sucesso ao remover imagem!")
                    } else {
                        print("Erro ao remover imagem!!")
                    }
                }
            }
        }
    }

}
