//
//  ViewController.swift
//  AppMyFaceID
//
//  Created by Davi Orzechowski on 27/05/24.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unlock(_ sender: Any) {
        var error: NSError?
        if(LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)){
            LAContext().evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Entrar no aplicativo", reply: {
                success,error in
                if(success){
                    DispatchQueue.main.sync {
                        self.resultLabel.text = "Deu certo!!!"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.resultLabel.text = "Erro ao desbloquear aplicativo"
                    }
                }
            })
            
            
        } else {
            self.resultLabel.text = "Permita que o aplicativo utilize o FaceID/TouchID nas configurações do iPhone."
        }
        
        
        
    }
    
}

