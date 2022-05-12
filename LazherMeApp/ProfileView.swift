//
//  ProfileView.swift
//  LazherMeApp
//
//  Created by theo on 10/05/2022.
//
// Vue affichant le profile de l'utilisateur connecté

//Import des librairies nécessaires
import FirebaseCore
import Firebase
import FirebaseDatabase
import SwiftUI

//Classe ProfileViewModel servant a charger
//l'username de l'utilisateur connecté
//a partir de son uid
class ProfileViewModel : ObservableObject {
    @EnvironmentObject var viewModel : AppViewModel
    @Published var email = "" // Variable contenant l'email de l'utilisateur
    @Published var username = ""// Variable contenant l'username de l'utilisateur
    init() {
        fetchCurrentUser() // A l'initialisation on execute la fonction fetchCurrentUser()
    }
    //Fonction fetchCurrentUser() qui lie l'uid et l'username en bdd
    private func fetchCurrentUser() {
        var ref: DatabaseReference! // Variable de reference a notre bdd
        
        ref = Database.database(url:"https://isen-lazherme-default-rtdb.europe-west1.firebasedatabase.app").reference() //Definition de la reference a la bdd
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        // On récupère l'uid de l'utilisateur connecté
        ref.child("Users/\(uid)/username").getData(completion:  { error, snapshot in
            guard error == nil else {
                // On va rechercher dans notre bdd l'username correspondant
                print(error!.localizedDescription)
                return // Si il existe...
            }
            let userName = snapshot?.value as? String ?? "Unknown"
            self.username = "\(userName)" //On definit cet username
        })
        guard let email = FirebaseManager.shared.auth.currentUser?.email else {return}
        self.email = "\(email)" // On definit l'email
    }
}

//Structure de la Vue Profile
struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel() // On récupère notre objet qui stocke les infos
    var body: some View {
        Image(systemName: "person.circle.fill")
            .font(.system(size: 200.0))
            .padding(.bottom,50.0)
        //On affiche le username et l'email
        Text(vm.username)
            .font(.system(size: 50.0))
            .padding(.bottom,20.0)
        Text(vm.email)
            .font(.system(size: 30.0))
            .fontWeight(.light)
        
    }
}
//Preview pour xcode
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
