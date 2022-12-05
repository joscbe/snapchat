//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 03/12/22.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imagem: UIImageView!
    @IBOutlet var edtDescricao: UITextField!
    @IBOutlet var btnProximo: UIButton!
    
    var imagePicker = UIImagePickerController()

    @IBAction func selecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        
        present(imagePicker, animated: true)
    }
    
    @IBAction func ProximoPasso(_ sender: Any) {
        self.btnProximo.isEnabled = false
        self.btnProximo.setTitle("Carregando...", for: .disabled)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        //Recupera Imagem
        if let imagemSelecionada = self.imagem.image?.jpegData(compressionQuality: 0.5) {
            //let imagemDados = imagemSelecionada.jpegData(compressionQuality: 0.5)
            imagens.child("image.jpg").putData(imagemSelecionada, metadata: nil) { metaDados, erro in
                if erro == nil {
                    print("Sucesso ao fazer upload do arquivo!")
                    
                    self.btnProximo.isEnabled = true
                    self.btnProximo.setTitle("Próximo", for: .normal)
                } else {
                    print("Erro ao fazer upload do arquivo!")
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.imagem.image = imagemRecuperada
        imagePicker.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

}
