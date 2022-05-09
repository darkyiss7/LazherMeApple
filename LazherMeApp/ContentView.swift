//
//  ContentView.swift
//  LazherMeApp
//
//  Created by theo on 23/03/2022.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject{
    let auth = Auth.auth()
    @Published var signedIn = false
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){
            [weak self]
            result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){
            [weak self]
            result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
}
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)
let darkGreyColor = Color(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0)
struct ContentView: View {
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                HomeView()
            }
            else{
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
        .environmentObject(viewModel)
    }
}
struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isLinkActive = false
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        VStack(alignment: .center) {
            ImageView()
            EmailTextField(email: $email)
            PasswordTextField(password: $password)
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else{
                    return
                }
                viewModel.signIn(email: email, password: password)
            }) {
                LoginBouton()
            }
            NavigationLink("Pas encore membre? Creer un compte",destination: SignUpView()).foregroundColor(darkGreyColor).font(.system(size : 15.0))
        }
        .padding()
        .navigationBarTitle(Text("Connexion"))
    }
}
struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isLinkActive = false
    @EnvironmentObject var viewModel : AppViewModel
    var body: some View {
        VStack(alignment: .center) {
            ImageView()
            EmailTextField(email: $email)
            PasswordTextField(password: $password)
            Button(action: {
                self.isLinkActive = true
                guard !email.isEmpty, !password.isEmpty else{
                    return
                }
                viewModel.signUp(email: email, password: password)
            }) {
                CreateBouton()
            }
        }
        .padding()
        .navigationBarTitle(Text("Inscription").foregroundColor(purpleDark))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageView: View{
    var body: some View{
        Image("logo_violet")
            .resizable()
            .frame(width: 450, height: 220)
    }
}


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
struct CreateBouton: View {
    var body: some View {
        Text("CREER")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .background(purpleDark)
            .cornerRadius(35.0)
    }
}

