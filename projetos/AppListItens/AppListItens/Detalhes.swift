//
//  Detalhes.swift
//  AppListItens
//
//  Created by Rafael Leonan on 08/07/24.
//

import Foundation
import UIKit

class Detalhes: UIViewController {
    @IBOutlet weak var descricao: UILabel!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let parametros = Global.parametros
        let resultado = parametros?["resultado"] as? NSDictionary
        let nome = resultado?["name"] as? String
        descricao.text = nome
        self.navigationItem.title = nome
    }
}
