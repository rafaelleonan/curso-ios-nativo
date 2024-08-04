//
//  SwiftUIView.swift
//  AppUIKitWithSwiftUI
//
//  Created by Davi Orzechowski on 21/05/24.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.navigationController) var navigationController
    var body: some View {
        VStack{
            Spacer()
            Text("tela 2 - SwiftUI")
            Spacer()
            Button {
                let View = ViewController3()
                let global = Global()
                Global.parametros["tela3"] = "oi do SwiftUI"
                global.proximaView(viewController: View, id: "ViewController3", navigation: navigationController!, storyboardName: "Main")
            } label: {
                Text("Ir para tela 3")
            }
            Spacer()
        }
    }
}

//#Preview {
//    SwiftUIView()
//}

