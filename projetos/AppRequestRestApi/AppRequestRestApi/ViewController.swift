//
//  ViewController.swift
//  AppRequestRestApi
//
//  Created by Davi Orzechowski on 22/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinnerLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var chamarBotao: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func chamar(_ sender: Any) {
        spinner.isHidden = false
        spinnerLabel.isHidden = false
        spinner.startAnimating()
        spinnerLabel.text = "Buscando informações..."
        let queue = DispatchQueue(label: "downloader")
        queue.async(execute: {
            let api = API()
            api.buscarElemento(completion: {
                result in
                DispatchQueue.main.async(execute: {
                    let statusCode = (result?["statusCode"] as! NSString).integerValue
                    if(statusCode == 200){
                        print(result!)
                        self.resultado.text = (result?["data"] as? NSDictionary)?["title"] as? String ?? "error"
                        self.spinnerLabel.isHidden = true
                    } else {
                        self.spinnerLabel.text = result?["statusCode"] as? String ?? "error"
                    }
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                    
                })
            })
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        spinner.isHidden = true
        spinnerLabel.isHidden = true
    }
}

