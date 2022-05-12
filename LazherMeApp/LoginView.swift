//
//  LoginView.swift
//  LazherMeApp
//
//  Created by theo on 12/05/2022.
//

import SwiftUI

// Structure de la Vue pour se connecter
struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isLinkActive = false
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        VStack(alignment: .center) {
            ImageView() // Le logo
            EmailTextField(email: $email) // Champs email
            PasswordTextField(password: $password) // Champs mot de passe
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else{
                    // On verifie que les champs ne sont pas vides
                    return
                }
                viewModel.signIn(email: email, password: password)
                //On connecte l'utilisateur avec la methode signUp
            }) {
                LoginBouton() // Bouton se connecter
            }
            NavigationLink("Pas encore membre? Creer un compte",destination: SignUpView()).foregroundColor(darkGreyColor).font(.system(size : 15.0)) // Texte qui redirige vers la page s'inscrire
        }
        .padding()
        .navigationBarTitle(Text("Connexion"))
    }
}
// Structure qui correspond au bouton se connecter
struct LoginBouton: View {
    var body: some View {
        Text("CONNEXION")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .background(purpleDark)

    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
