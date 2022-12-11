//
//  Snap.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 10/12/22.
//

import Foundation

class Snap {
    var id: String
    var nome: String
    var de: String
    var descricao: String
    var idImagem: String
    var urlImagem: String
    
    init(id: String, nome: String, de: String, descricao: String, idImagem: String, urlImagem: String) {
        self.id = id
        self.nome = nome
        self.de = de
        self.descricao = descricao
        self.idImagem = idImagem
        self.urlImagem = urlImagem
    }
}
