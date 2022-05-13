//
//  SignUpView.swift
//  LazherMeApp
//
//  Created by theo on 12/05/2022.
//
// Vue pour l'inscription
import SwiftUI

struct SignUpView: View {
    @State var email: String = "" // Variable pour l'email
    @State var password: String = "" // Variable pour le mot de passe
    @State var isLinkActive = false
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        VStack(alignment: .center) {
            ImageView() // Le logo
            EmailTextField(email: $email) // Champs email
            PasswordTextField(password: $password) // Champs mot de passe
            Button(action: {
                self.isLinkActive = true
                guard !email.isEmpty, !password.isEmpty else{
                    // On verifie que les champs ne sont pas vides
                    return
                }
                viewModel.signUp(email: email, password: password)
                //On inscrit l'utilisateur avec la methode signUp
            }) {
                RegisterBouton() // Bouton s'enregistrer
            }
        }
        .padding()
        .navigationBarTitle(Text("Inscription").foregroundColor(.white))
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
