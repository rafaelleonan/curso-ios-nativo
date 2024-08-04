//
//  ViewController.swift
//  AppUIKitWithSwiftUI
//
//  Created by Davi Orzechowski on 21/05/24.
//

import UIKit
import SwiftUI
class ViewController: UIViewController {

    @IBAction func next(_ sender:Any){
        let viewController = UIHostingController(rootView:SwiftUIView().environment(\.navigationController, self.navigationController) )
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

