//
//  CreateView.swift
//  LazherMeApp
//
//  Created by theo on 09/05/2022.
//
// Vue servant a creer une partie

import SwiftUI
//Import des librairies nécessaires
import FirebaseCore
import Firebase
import FirebaseDatabase

//Structure de la vue CreateView
struct CreateView: View {
    @EnvironmentObject var vm : HomeViewModel
    //Fonction pour generer le code de la partie
    func randomString(length: Int) -> String {
      let letters = "123456789ABCDEFGHIJKLMNPGRSTUVWXYZ"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    func CreateGame(mode: String,joueurs:String,temps:String){
        var ref : DatabaseReference! // Variable de reference a notre bdd
        
        ref = Database.database(url:"https://isen-lazherme-default-rtdb.europe-west1.firebasedatabase.app").reference() //Definition de la reference a la bdd
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        guard let email = FirebaseManager.shared.auth.currentUser?.email else {return}
        let code = randomString(length: 5)
        //self.ref.child("Games").child(code).child().setValue(["username": username])
        ref.child("Games").child(code).child("gameSpecs").child("ownerEmail").setValue(email)
        ref.child("Games").child(code).child("gameSpecs").child("gameCode").setValue(code)
        ref.child("Games").child(code).child("gameSpecs").child("gameMode").setValue(mode)
        ref.child("Games").child(code).child("gameSpecs").child("playerMax").setValue(joueurs)
        ref.child("Games").child(code).child("gameSpecs").child("timeMax").setValue(temps)
        ref.child("Games").child(code).child("gameSpecs").child("playersInGame").setValue(1)
        ref.child("Games").child(code).child("gameSpecs").child("gameState").setValue(0)
        ref.child("Games").child(code).child("players").child(uid).child("email").setValue(email)
        //ref.child("Games").child(code).child("players").child(uid).child("username").setValue(userName)
        ref.child("Games").child(code).child("players").child(uid).child("team").setValue("blue")
        ref.child("Games").child(code).child("players").child(uid).child("kill").setValue(0)
        ref.child("Games").child(code).child("players").child(uid).child("death").setValue(0)
        ref.child("Games").child(code).child("players").child(uid).child("idInGame").setValue(0)
        ref.child("Users").child(uid).child("games").child(code).setValue(0)
        ref.child("Users").child(uid).child("currentgame").setValue(code)
    }
    @State private var favoriteMode = "Team-Deathmatch" //Mode par défaut
    var modes = ["Team-Deathmatch", "Free-For-All"] // Modes de jeu
    @State private var favoriteNombre = "2" // Nombre de joueurs par défaut
    var nombres = ["2", "4", "6", "8", "10", "12"] // Nombres possibles
    @State private var favoriteTemps = "2" // Temps par défaut
    var temps = ["10", "20", "30"] //Temps possibles
    var body: some View {
        VStack{
            Text("Creer une partie")
                .font(.largeTitle)
                .padding(.bottom,50.0)
            HStack{
                //Selection du mode de jeu
                Text("Mode de jeu")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                Picker("Mode de jeu", selection: $favoriteMode) {
                    // Selection par l'utilisateur
                    ForEach(modes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .padding(.trailing,30.0)
                .padding(.bottom , 20.0)
            }
            
            
            HStack{
                //Selection du nombre de joueurs
                Text("Nombre de joueurs")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                Picker("Nombre de joueurs", selection: $favoriteNombre) {
                    // Selection par l'utilisateur
                    ForEach(nombres, id: \.self) {
                        Text($0)
                            .font(.system(size: 15.0))
                    }
                }
                .pickerStyle(.menu)
                .padding(.trailing,70.0)
                .padding(.bottom , 20.0)
            }
            HStack{
                //Selection du temps
                Text("Temps")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                Picker("Temps", selection: $favoriteTemps) {
                    // Selection par l'utilisateur
                    ForEach(temps, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .padding(.trailing,70.0)
                
            }
            .padding(.bottom,40.0)
            Button {
                print("Bouton creer")
                CreateGame(mode: favoriteMode, joueurs: favoriteNombre, temps: favoriteTemps)
                self.vm.isInGame = true
            } label: {
                CreerBouton()
            }
            
        }
    }
}
//Preview pour xcode
struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
//Structure du bouton creer une partie
struct CreerBouton: View {
    var body: some View {
        
        Text("CREER")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(purpleDark)
    }
}
