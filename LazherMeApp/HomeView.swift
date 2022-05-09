//
//  HomeView.swift
//  LazherMeApp
//
//  Created by Theo Dubois on 24/03/2022.
//

import SwiftUI
let purpleDark = Color(red: 123.0/255.0, green: 57.0/255.0, blue: 255.0/255.0)
struct HomeView: View {
    @State var code: String = ""
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        VStack{
            CreerBouton()
                .padding(.bottom, 50.0)
            CodeTextField(code: $code)
                .padding(.bottom, 0.0)
            NavigationLink(destination: BLEScan()){
                    RejoindreBouton()
                    .padding(.bottom, 0.0)
            }
            Button(action: {
                viewModel.signOut()
            }){
                DecoBouton()
                    .padding(.top, 100.0)
            }
        }
        .navigationBarTitle(Text("Accueil"))
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct CreerBouton: View {
    var body: some View {
        Text("CREER UNE PARTIE")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(.blue)
            .cornerRadius(35.0)
    }
}
struct RejoindreBouton: View {
    var body: some View {
        Text("REJOINDRE UNE PARTIE")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(.blue)
            .cornerRadius(35.0)
    }
}
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

struct DecoBouton: View {
    var body: some View {
        Text("SE DECONNECTER")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(.red)
            .cornerRadius(35.0)
    }
}
