//
//  HomeView.swift
//  LazherMeApp
//
//  Created by Theo Dubois on 24/03/2022.
//  Page d'accueil une fois l'utilisateur connecté

import SwiftUI

//Import des librairies nécessaires
import FirebaseCore
import Firebase
import FirebaseDatabase

class HomeViewModel : ObservableObject {
    @EnvironmentObject var viewModel : AppViewModel
    @Published var currentgame = ""// Variable contenant l'username de l'utilisateur
    @Published var isInGame = false  // Boolean si connecté ou non
    
    init() {
        isInGame = userIsInGame // A l'initialisation on execute la fonction fetchCurrentUser()
    }
    //Fonction fetchCurrentUser() qui lie l'uid et l'username en bdd
    var userIsInGame :  Bool{
        var ref: DatabaseReference! // Variable de reference a notre bdd
        
        ref = Database.database(url:"https://isen-lazherme-default-rtdb.europe-west1.firebasedatabase.app").reference() //Definition de la reference a la bdd
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return false}
        // On récupère l'uid de l'utilisateur connecté
        ref.child("Users/\(uid)/currentgame").getData(completion:  { error, snapshot in
            guard error == nil else {
                // On va rechercher dans notre bdd l'username correspondant
                self.isInGame = false
                return // Si il existe...
            }

            let currentgame = snapshot?.value as? String ?? "Unknown"
            if (currentgame == "Unknown"){
                self.isInGame = false
            }else{
                self.isInGame = true
                self.currentgame = "\(currentgame)" //On definit cet username
            }
        })
        return self.isInGame
    }
}
struct HomeView: View {
    
    //Variables d'etat pour savoir si un bouton de du dropdown menu est cliqué (profile ou bluetooth)
    @State var toolbarLinkSelected = false
    @State var toolbarLink2Selected = false
    //On recupère notre environmentObject
    @EnvironmentObject var viewModel : AppViewModel
    @ObservedObject var homeVm = HomeViewModel()
    //Structure de la page
    var body: some View {
        if homeVm.userIsInGame {
            GameView()
                .environmentObject(homeVm)
        }else{
            

        VStack{
            TabView {
                CreateView()
                    .environmentObject(homeVm)
                //Vue creer une partie
                    .tabItem {
                        Image(systemName: "plus.circle.fill")
                        Text("Creer")
                    }
                JoinView() //Vue rejoindre une partie
                    .tabItem {
                        Image(systemName: "arrowtriangle.right.circle.fill")
                        Text("Rejoindre")
                    }
            }.accentColor(purpleDark)
        }
        .navigationBarTitle("Accueil", displayMode: .inline)
        
        .toolbar{
            ToolbarItem(placement: .principal) {
                Text("Accueil")
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .primaryAction) { // Barre du haut
                Menu { // Menu deroulant en haut a gauche
                    Button(action: {toolbarLinkSelected = true }) { //Bouton profile
                        Label("Profile", systemImage: "person")
                    }
                    Button(action: {toolbarLink2Selected = true}) { //Bouton bluetooth
                        Label("Bluetooth", systemImage: "folder")
                    }
                    Button(action: {viewModel.signOut()}) { //Bouton se deconnecter appellant la methode signOut()
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
        //On effectue des taches en arrière plan pour rediriger vers la page selectionnée sans sortir de la navigationView
        .background(
            //Tache pour le bouton profile
            NavigationLink(
                destination: ProfileView(),
                isActive: $toolbarLinkSelected
            ) {
                EmptyView()
            }.hidden()
        )
        //Tache pour le bouton bluetooth
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
}

