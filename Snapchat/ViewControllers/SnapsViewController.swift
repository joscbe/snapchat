//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 03/12/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var snaps: [Snap] = []
    @IBOutlet var tableview: UITableView!
    
    @IBAction func sair(_ sender: Any) {
        //Deslogar usuario
        do {
            try Auth.auth().signOut()
            //Fecha a tela
            dismiss(animated: true)
        } catch {
            print("Erro ao deslogar usuario")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let autenticacao = Auth.auth()
        
        if let uidUsuarioLogado = autenticacao.currentUser?.uid {
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            
            let snaps = usuarios.child(uidUsuarioLogado).child("snaps")
            
            //Cria um ouvinte para snaps
            snaps.observe(.childAdded) { snapshot in
                
                if let dados = snapshot.value as? NSDictionary {
                    
                    let id = snapshot.key
                    let nome = dados["nome"] as! String
                    let de = dados["de"] as! String
                    let descricao = dados["descricao"] as! String
                    let idImagem = dados["idImagem"] as! String
                    let urlImagem = dados["urlImagem"] as! String
                    
                    let snap = Snap(id: id, nome: nome, de: de, descricao: descricao, idImagem: idImagem, urlImagem: urlImagem)
                    
                    self.snaps.append(snap)
                    self.tableview.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        }
        
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaSnaps", for: indexPath)
        
        if snaps.count == 0 {
            cell.textLabel?.text = "Nenhum snap para você :("
        } else {
            let snap = self.snaps[indexPath.row]
            
            cell.textLabel?.text = snap.descricao
        }
        
        return cell
    }
}
