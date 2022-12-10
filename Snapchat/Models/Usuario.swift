//
//  Usuario.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 09/12/22.
//

import Foundation

class Usuario {
    var uid: String
    var nome: String
    var email: String
    
    init(uid: String, nome: String, email:String){
        self.uid = uid
        self.nome = nome
        self.email = email
    }
}
