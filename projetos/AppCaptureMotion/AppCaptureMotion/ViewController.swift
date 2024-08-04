//
//  ViewController.swift
//  AppCaptureMotion
//
//  Created by Davi Orzechowski on 23/05/24.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var eixoZ: UILabel!
    @IBOutlet weak var eixoY: UILabel!
    @IBOutlet weak var eixoX: UILabel!
    private var motionManager:CMMotionManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func iniciar(_ sender: Any) {
        motionManager = CMMotionManager()
        motionManager?.accelerometerUpdateInterval = 1/100
        let queue = OperationQueue.current
        motionManager?.startAccelerometerUpdates(to: queue!, withHandler: {
            motionData,error in
            let acceleration = motionData?.acceleration
            self.eixoX.text = String.init(format: "Eixo X: %.2f", acceleration?.x ?? 0.0)
            self.eixoY.text = String.init(format: "Eixo Y: %.2f", acceleration?.y ?? 0.0)
            self.eixoZ.text = String.init(format: "Eixo Z: %.2f", acceleration?.z ?? 0.0)
        })
        
    }
    @IBAction func parar(_ sender: Any) {
        if(motionManager != nil){
            motionManager?.stopAccelerometerUpdates()
            motionManager?.stopDeviceMotionUpdates()
        }
    }
}

