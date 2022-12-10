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
    var idImagem = NSUUID().uuidString

    @IBAction func selecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        
        present(imagePicker, animated: true)
    }
    
    @IBAction func ProximoPasso(_ sender: Any) {
        self.btnProximo.isEnabled = false
        self.btnProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        //Recupera Imagem
        if let imagemSelecionada = self.imagem.image?.jpegData(compressionQuality: 0.1) {
            let imagemRef = imagens.child("\(self.idImagem).jpg")
            imagemRef.putData(imagemSelecionada, metadata: nil) { metaDados, erro in
                if erro == nil {
                    print("Sucesso ao fazer upload do arquivo!")
                    
                    imagemRef.downloadURL { url, erro in
                        if erro == nil {
                            if let urlImage = url?.absoluteString {
                                self.performSegue(withIdentifier: "selecionarUsuario", sender: urlImage)
                            }
                        } else {
                            //6 Dicas para ESTUDAR PROGRAMAÇÃO e memorizar conteúdos mais fácil!
                        }
                    }
                    
                    self.btnProximo.isEnabled = true
                    self.btnProximo.setTitle("Próximo", for: .normal)
                } else {
                    print("Erro ao fazer upload do arquivo!")
                    let alerta = Alerta(titulo: "Upload Falhou", mensagem: "Erro ao fazer upload do arquivo, tente novamente!").getAlerta()
                    self.present(alerta, animated: true)
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.imagem.image = imagemRecuperada
        
        self.btnProximo.isEnabled = true
        self.btnProximo.backgroundColor = UIColor(red: 0.686, green: 0.322, blue: 0.871, alpha: 1)
        
        imagePicker.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selecionarUsuario" {
            let usuariosViewController = segue.destination as! UsuariosTableViewController
            
            usuariosViewController.descricao = self.edtDescricao.text!
            usuariosViewController.urlImagem = sender as! String
            usuariosViewController.idImagem = self.idImagem
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        //Desabilita botão
        btnProximo.isEnabled = false
        btnProximo.backgroundColor = UIColor.gray
    }

}
