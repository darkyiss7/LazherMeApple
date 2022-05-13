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

struct GameView: View {
    @EnvironmentObject var vm : HomeViewModel
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
                    List(){
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
