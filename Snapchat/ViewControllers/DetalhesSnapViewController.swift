//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 12/12/22.
//

import UIKit
import SDWebImage

class DetalhesSnapViewController: UIViewController {

    @IBOutlet var imagem: UIImageView!
    @IBOutlet var detalhesLabel: UILabel!
    @IBOutlet var contadorLabel: UILabel!
    
    var snap: Snap?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let snap = snap {
            let urlImagem = URL(string: snap.urlImagem)
            
            imagem.sd_setImage(with: urlImagem) { uiImagem, erro, cache, url in
                if erro == nil{
                    print("imagem exibida!")
                }
            }
            
            detalhesLabel.text = snap.descricao
        }
    }

}
