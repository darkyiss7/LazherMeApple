//
//  ProfileView.swift
//  LazherMeApp
//
//  Created by theo on 10/05/2022.
//
import FirebaseCore
import Firebase
import FirebaseDatabase
import SwiftUI
class ProfileViewModel : ObservableObject {
    @EnvironmentObject var viewModel : AppViewModel
    @Published var email = ""
    @Published var username = ""
    init() {
        fetchCurrentUser()
    }
    private func fetchCurrentUser() {
        var ref: DatabaseReference!

        ref = Database.database(url:"https://isen-lazherme-default-rtdb.europe-west1.firebasedatabase.app").reference()
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        ref.child("Users/\(uid)/username").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return
          }
            let userName = snapshot?.value as? String ?? "Unknown"
            self.username = "\(userName)"
        })
        guard let email = FirebaseManager.shared.auth.currentUser?.email else {return}
        self.email = "\(email)"
    }
}
struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel()
    var body: some View {
        Image(systemName: "person.circle.fill")
            .font(.system(size: 200.0))
            .padding(.bottom,50.0)
        Text(vm.username)
            .font(.system(size: 50.0))
            .padding(.bottom,20.0)
        Text(vm.email)
            .font(.system(size: 30.0))
            .fontWeight(.light)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
