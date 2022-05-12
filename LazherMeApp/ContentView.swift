//
//  ContentView.swift
//  LazherMeApp
//
//  Created by theo on 23/03/2022.
//

// Import des librairies utilisées
import SwiftUI
import FirebaseAuth
import Firebase

//Definition des couleurs personnalisées
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)
let darkGreyColor = Color(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0)
let purpleDark = Color(red: 123.0/255.0, green: 57.0/255.0, blue: 255.0/255.0)

//Classe FirebaseManager qui permet de recuperer notre utilisateur connecté
class FirebaseManager : NSObject {
    let auth : Auth  // Utilisateur connecté
    static let shared = FirebaseManager() // Champ a appeler
    override init(){ // Initialisation, definition de l'utilisateur
        self.auth = Auth.auth()
        super.init()
    }
}
// Class AppViewModel qui gère si un utilisateur est connecté ou non
class AppViewModel: ObservableObject{
    let auth = Auth.auth() // Utilisateur connecté
    @Published var signedIn = false  // Boolean si connecté ou non
    var isSignedIn: Bool {
        return FirebaseManager.shared.auth.currentUser != nil // On regarde si l'utilisateur actuel est different du nul
    }
    // Fonction pour se connecter
    func signIn(email: String, password: String){
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password){
            [weak self]
            result, error in
            guard result != nil, error == nil else {
                return // Si la connexion n'a pas fonctionné on retourne l'erreur
            }
            DispatchQueue.main.async {
                self?.signedIn = true // Sinon on dit que l'utilisateur est connecté
            }
        }
        
    }
    // Fonction pour s'enregistrer
    func signUp(email: String, password: String){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){
            [weak self]
            result, error in
            guard result != nil, error == nil else {
                return // Si l'inscription n'a pas fonctionné on retourne l'erreur
            }
            DispatchQueue.main.async {
                self?.signedIn = true // Sinon on connecte l'utilisateur avec le compte crée
            }
        }
    }
    // Fonction pour se deconnecter
    func signOut() {
        try? FirebaseManager.shared.auth.signOut()
        
        self.signedIn = false
    }
}


//Structure de la page
struct ContentView: View {
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        //Creation d'une navigationView
        NavigationView {
            if viewModel.signedIn {
                //Si un utilisateur est connecté on affiche l'accueil
                HomeView()
            }
            else{
                //Sinon on affiche le page de connexion
                LoginView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn // Quand la page apparait, on regarde si l'utilisateur est connecté, on met true dans signedIn si la methode isSignedIn renvoie true et inversement
        }
        .environmentObject(viewModel)
        //On definit l'environmentObject qui va permettre de recuperer l'uid de l'utilisateur connecté
    }
}

// Pour la preview dans xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// Structure qui correspond au logo de l'application
struct ImageView: View{
    var body: some View{
        Image("logo_violet")
            .resizable()
            .frame(width: 450, height: 220)
    }
}

// Structure qui correspond au champs email
struct EmailTextField: View{
    @Binding var email : String
    var body: some View {
        TextField(("Email"), text: $email)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom,20)
    }
}
// Structure qui correspond au champs mot de passe
struct PasswordTextField: View {
    @Binding var password : String
    var body: some View {
        SecureField(("Mot de passe"), text: $password)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom,20)
    }
}

// Structure qui correspond au bouton s'enregistrer
struct RegisterBouton: View {
    var body: some View {
        Text("INSCRIPTION")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .background(purpleDark)
            .cornerRadius(35.0)
    }
}


