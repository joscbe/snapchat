//
//  UsuariosTableViewController.swift
//  Snapchat
//
//  Created by Josebe Barbosa on 08/12/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsuariosTableViewController: UITableViewController {
    
    var usuarios: [Usuario] = []
    var descricao: String = ""
    var urlImagem: String = ""
    var idImagem: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database = Database.database().reference()
        let usuarios = database.child("usuarios")
        
        /** Adicione evento novo usuario adicionado **/
        usuarios.observe(.childAdded) { snapshot in
            let dados = snapshot.value as? NSDictionary
            
            //Recupera dados do usuario
            let uid = snapshot.key
            let nome = dados?["nome"] as! String
            let email = dados?["email"] as! String
            
            let user = Usuario(uid: uid, nome: nome, email: email)
            
            //Adiciona o usuario no array de usuarios
            self.usuarios.append(user)
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaUsuarios", for: indexPath)

        // Configura a celula
        let user = self.usuarios[indexPath.row]
        cell.textLabel?.text = user.nome
        cell.detailTextLabel?.text = user.email

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuarioSelecionado = self.usuarios[indexPath.row]
        let uidUsuarioSelecionado = usuarioSelecionado.uid
        
        //Referencia o banco de dados
        let database = Database.database().reference()
        let usuario = database.child("usuarios")
        
        let snaps = usuario.child(uidUsuarioSelecionado).child("snaps")
        
        //Recupera dados do usuario logado
        let autenticacao = Auth.auth()
        
        if let uidUsuarioLogado = autenticacao.currentUser?.uid {
            usuario.child(uidUsuarioLogado).observeSingleEvent(of: .value) { snapshot in
                
                if let dados = snapshot.value as? NSDictionary {
                    let snap = [
                        "de": dados["email"] as! String,
                        "nome": dados["nome"] as! String,
                        "descricao": self.descricao,
                        "urlImage": self.urlImagem,
                        "idImagem": self.idImagem
                    ]
                    
                    snaps.childByAutoId().setValue(snap)
                }
            }
        }
        
        //print(usuarioSelecionado.nome)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
