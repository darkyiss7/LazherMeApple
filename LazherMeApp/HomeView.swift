//
//  HomeView.swift
//  LazherMeApp
//
//  Created by Theo Dubois on 24/03/2022.
//

import SwiftUI
let purpleDark = Color(red: 123.0/255.0, green: 57.0/255.0, blue: 255.0/255.0)
struct HomeView: View {
    
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        VStack{
            TabView {
               CreateView()
                 .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Creer")
                  }
               JoinView()
                 .tabItem {
                     Image(systemName: "arrowtriangle.right.circle.fill")
                    Text("Rejoindre")
                  }
            }.accentColor(purpleDark)
        }
        
        .navigationBarTitle(Text("Accueil"))
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
            Button{
                viewModel.signOut()
            } label : {
                Image(systemName: "ellipsis.circle")
            }
        }
        }
        
    }

        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
