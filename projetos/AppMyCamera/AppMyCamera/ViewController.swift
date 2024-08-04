//
//  ViewController.swift
//  AppMyCamera
//
//  Created by Davi Orzechowski on 27/05/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imagem: UIImageView!
    private var picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.allowsEditing = true
    }

    @IBAction func tirarfoto(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            if(AVCaptureDevice.authorizationStatus(for: .video) == .authorized){
                picker.sourceType = .camera
                picker.showsCameraControls = true
                present(picker, animated: true)
            } else {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: {
                    granted in
                    if granted {
                        DispatchQueue.main.async() {
                            self.picker.sourceType = .camera
                            self.picker.showsCameraControls = true
                            self.present(self.picker, animated: true)
                        }
                    } else {
                        let alert = UIAlertController(title: "Erro", message: "Camera indisponível, habilite a funcionalidade nas configurações do iPhone", preferredStyle: .alert)
                        let cancel = UIAlertAction(title: "Ok", style: .cancel)
                        alert.addAction(cancel)
                        self.present(alert, animated: true)
                    }
                })
            }
            
        } else {
            let alert = UIAlertController(title: "Erro", message: "Camera indisponível", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func fototeca(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let myimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imagem.image = myimage
    }
    
}

