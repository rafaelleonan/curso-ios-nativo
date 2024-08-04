//
//  Global.swift
//  AppListItens
//
//  Created by Rafael Leonan on 08/07/24.
//

import Foundation
import UIKit


class Global:NSObject {
    static var parametros:NSMutableDictionary?
    public func proximaView(viewController proximaTela:UIViewController,id nomeView:String,navigation nav:UINavigationController,storyboardName story:String){
        let storyboard = UIStoryboard.init(name: story, bundle: nil)
        var nextView = proximaTela
        nextView = storyboard.instantiateViewController(withIdentifier: nomeView)
        nav.pushViewController(nextView, animated: true)
    }
    public func salvarPlist(oDicionario dicionario:NSMutableDictionary,naPlist nomeArquivo:String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let plist = String.init(format: "%@.plist", nomeArquivo)
        let path = documentsDirectory.appending(plist)
        dicionario.write(toFile: path, atomically: true)
    }
    public func leituraPlist(nome nomePlist:String) -> NSMutableDictionary{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let plist = String.init(format: "%@.plist", nomePlist)
        let path = documentsDirectory.appending(plist)
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)){
            let bundle = Bundle.main.path(forResource: nomePlist, ofType: "plist")!
            do{
                try fileManager.copyItem(atPath: bundle, toPath: path)
            } catch {
                
            }
        }
        var savedstock = NSMutableDictionary.init(contentsOfFile: path)
        if(savedstock == nil){
            savedstock = NSMutableDictionary()
        }
        return savedstock!
    }
}
