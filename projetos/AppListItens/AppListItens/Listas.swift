//
//  Listas.swift
//  AppListItens
//
//  Created by Rafael Leonan on 08/07/24.
//

import Foundation
import UIKit

// NSLog()
// %@ para strings
// %i para inteiros
// %f para decimais
// e muito mais...
// NSLog("V1 maior que V4 com valor %i", v1)

// CONDICIONAIS
//if (v1 > v4) {
//    NSLog("V1 maior que V4 com valor %i", v1)
//} else if (v1 == 10) {
//    NSLog("V1 igual a 10, %i", v1)
//} else {
//    NSLog("V1: %i", v1)
//}


// CLICAR NO NÚMERO DA LINHA PARA HABILITAR/DESABILITAR BREAKPOINTS

class Listas:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabela: UITableView!
    
    var elements = NSMutableArray()
    var el = [
        ["name": "Compras do Domingo", "itens": "10"],
        ["name": "Supermercado", "itens": "30"],
        ["name": "Happy Hour", "itens": "5"]
    ]
    
    override func viewDidLoad() { // EXECUTA CÓDIGO ANTES DA TELA SER
        tabela.delegate = self
        tabela.dataSource = self
        let global = Global()
        let database = global.leituraPlist(nome: "Database")
        // print(database)
        elements = (database["listas"] as? NSMutableArray)!
        // let dicionario = NSMutableDictionary()
        // dicionario["listas"] = el
        // global.salvarPlist(oDicionario: dicionario, naPlist: "Database")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Listas"
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ListasCell"
        let cell: ListasCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListasCell
        let dicionario = elements.object(at: indexPath.row) as? NSDictionary
        cell.titulo.text = dicionario?["name"] as? String
        cell.quantidade.text = dicionario?["itens"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Toque na linha para selecionar uma lista."
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dicionario = elements[indexPath.row]
        print(dicionario)
        tabela.reloadData()
        let global = Global()
        let detalhes = Detalhes()
        Global.parametros = NSMutableDictionary()
        Global.parametros?["resultado"] = dicionario
        global.proximaView(viewController: detalhes, id: "Detalhes", navigation: self.navigationController!, storyboardName: "Main")
        
        
    }
    
}
