//
//  GameView.swift
//  LazherMeApp
//
//  Created by theo on 10/05/2022.
//

import SwiftUI
//Import des librairies nécessaires
import FirebaseCore
import Firebase
import FirebaseDatabase
class GameViewMode : ObservableObject {
    @EnvironmentObject var viewModel : AppViewModel
    @Published var email = "" // Variable contenant l'email de l'utilisateur
    @Published var username = ""// Variable contenant l'username de l'utilisateur
    @Published var usersBlue = [String]()
    @EnvironmentObject var vm : HomeViewModel
    init() {
        fetchCurrentUser() // A l'initialisation on execute la fonction fetchCurrentUser()
    }
    //Fonction fetchCurrentUser() qui lie l'uid et l'username en bdd
    private func fetchCurrentUser() {
        
        var ref: DatabaseReference! // Variable de reference a notre bdd
        
        ref = Database.database(url:"https://isen-lazherme-default-rtdb.europe-west1.firebasedatabase.app").reference() //Definition de la reference a la bdd
        
        // Listen for new comments in the Firebase database
        ref.child("Games").child(vm.currentgame).child("players").observe(.childAdded, with: { (snapshot) -> Void in
            let result = snapshot.value
            let resultString = String(describing: result)
            self.usersBlue.append(resultString)
        //  self.List.insertRows(
        //    at: [IndexPath(row: self.usersBlue.count - 1, section: self.kSectionComments)],
        //    with: UITableView.RowAnimation.automatic
        //   )
          })
        //  // Listen for deleted comments in the Firebase database
        //  ref.observe(.childRemoved, with: { (snapshot) -> Void in
           // let index = self.indexOfMessage(snapshot)
            //self.usersBlue.remove(at: index)
        //    self.List.deleteRows(
        //      at: [IndexPath(row: index, section: self.kSectionComments)],
        //      with: UITableView.RowAnimation.automatic
        //    )
         // })
    }
}
struct GameView: View {
    @EnvironmentObject var vm : HomeViewModel
    @ObservedObject var vmGame = GameViewMode()
    var body: some View {
        VStack{
            HStack(alignment:.center){
                VStack{
                    Text("Quitter")
                        .foregroundColor(.white)
                    Button {
                        print("Leave button was tapped")
                    } label: {
                        Image(systemName: "clear.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 25.0))
                    }
                }
                VStack{
                    Text("Code de la partie")
                        .foregroundColor(.white)
                    Text(vm.currentgame)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                VStack{
                    Text("Commencer")
                        .foregroundColor(.white)
                    Button {
                        print("Commencer la partie")
                    } label: {
                        Image(systemName: "play.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 25.0))
                    }
                }
            }
            .frame(maxWidth: .infinity)
                .background(purpleDark)
            HStack{
                Text("Mode")
                    .foregroundColor(.white)
                Text("Joueurs")
                    .foregroundColor(.white)
                Text("Temps")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
                .background(darkGreyColor)
            .padding(.bottom,10.0)
            HStack{
                //Team bleu
                VStack{
                    HStack{
                        Image(systemName: "person.2.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 20.0))
                        Text("Team Bleu")
                            .foregroundColor(.blue)
                            .font(.system(size: 20.0))
                    }
                    .padding()
                    List(vmGame.usersBlue,id: \.self){ users in
                        Text("\(users)")
                    }
                }
                //Team rouge
                VStack{
                    HStack{
                        Image(systemName: "person.2.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 20.0))
                        Text("Team Rouge")
                            .foregroundColor(.red)
                            .font(.system(size: 20.0))
                    }
                    .padding()
                    List{
                    }
                    
                }
            }
            Spacer()
            Button {
                print("Leave button was tapped")
            } label: {
                Image(systemName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right")
                    .font(.system(size: 25.0))
                    .foregroundColor(purpleDark)
            }
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
