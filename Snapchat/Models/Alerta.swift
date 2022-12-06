//
//  Alerta.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 05/12/22.
//

import UIKit

class Alerta {
    var titulo: String
    var mensagem: String
    
    init(titulo:String, mensagem:String){
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func getAlerta() -> UIAlertController {
        let alerta = UIAlertController(title: self.titulo, message: self.mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancelar", style: .default)
        
        alerta.addAction(action)
        
        return alerta
    }
}
