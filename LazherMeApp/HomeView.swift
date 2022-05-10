//
//  HomeView.swift
//  LazherMeApp
//
//  Created by Theo Dubois on 24/03/2022.
//

import SwiftUI


let purpleDark = Color(red: 123.0/255.0, green: 57.0/255.0, blue: 255.0/255.0)

struct HomeView: View {
    
    @State var toolbarLinkSelected = false
    @State var toolbarLink2Selected = false
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

        .navigationBarTitle("Try it!", displayMode: .inline)

        .toolbar{
            ToolbarItem(placement: .principal) {
                            Text("Accueil")
                    .foregroundColor(.white)
                        }
            ToolbarItem(placement: .primaryAction) {
                Menu {
                        Button(action: {toolbarLinkSelected = true }) {
                            Label("Profile", systemImage: "person")
                        }
                        Button(action: {toolbarLink2Selected = true}) {
                            Label("Bluetooth", systemImage: "folder")
                        }
                    Button(action: {viewModel.signOut()}) {
                        Label("Deconnexion", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            label: {
                Label("More", systemImage: "ellipsis.circle")
                    .font(.system(size: 20.0))
                    .foregroundColor(.white)
            }
            }
        }
        
        .background(
                        NavigationLink(
                            destination: ProfileView(),
                            isActive: $toolbarLinkSelected
                        ) {
                            EmptyView()
                        }.hidden()
                        )
        .background(
                        NavigationLink(
                            destination: BLEScan(),
                            isActive: $toolbarLink2Selected
                        ) {
                            EmptyView()
                        }.hidden()
                        )
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
