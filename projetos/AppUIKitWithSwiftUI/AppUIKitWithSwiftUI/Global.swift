//
//  Global.swift
//  AppUIKitWithSwiftUI
//
//  Created by Davi Orzechowski on 21/05/24.
//

import Foundation
import UIKit
import SwiftUI

@objcMembers
class Global:NSObject {
    static var parametros = NSMutableDictionary()
    public func proximaView(viewController proximaTela:UIViewController,id nomeView:String,navigation nav:UINavigationController,storyboardName story:String){
        let storyboard = UIStoryboard.init(name: story, bundle: nil)
        var nextView = proximaTela
        nextView = storyboard.instantiateViewController(withIdentifier: nomeView)
        nav.pushViewController(nextView, animated: true)
    }
    
}
extension EnvironmentValues {
    var navigationController: NavigationControllerKey.Value {
        get {
            return self[NavigationControllerKey.self]
        }
        set {
            self[NavigationControllerKey.self] = newValue
        }
    }
}
struct NavigationControllerKey: EnvironmentKey {
    static let defaultValue: UINavigationController? = nil
}
