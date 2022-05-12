//
//  JoinView.swift
//  LazherMeApp
//
//  Created by theo on 09/05/2022.
//
// Vue servant a rejoindre une partie

import SwiftUI

//Structure de la Vue
struct JoinView: View {
    @State var code: String = ""
    var body: some View {
        VStack{
            Text("Rejoindre une partie")
                .font(.largeTitle)
                .padding(.bottom,50.0)
            CodeTextField(code: $code) //Champ code de la partie
                .padding(.bottom, 50.0)
                .padding(.leading,20.0)
                .padding(.trailing,20.0)
            NavigationLink(destination: BLEScan()){
                RejoindreBouton()
                    .padding(.bottom, 0.0)
            }
        }
        
    }
}
//Pour la preview su xcode
struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView()
    }
}
//Structure du bouton rejoindre
struct RejoindreBouton: View {
    var body: some View {
        Text("REJOINDRE")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(purpleDark)
    }
}
//Structure du champ pour le code de la partie a rejoindre
struct CodeTextField: View{
    @Binding var code : String
    var body: some View {
        TextField(("Code de la partie"), text: $code)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom,20)
    }
}

