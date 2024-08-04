//
//  ViewController3.swift
//  AppUIKitWithSwiftUI
//
//  Created by Davi Orzechowski on 21/05/24.
//

import Foundation
import UIKit
class ViewController3:UIViewController {
    @IBOutlet weak var result:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let global = Global()
        result?.text = Global.parametros["tela3"] as? String ?? ""
    }
}
