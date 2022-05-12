//
//  SplashScreenView.swift
//  LazherMeApp
//
//  Created by theo on 09/05/2022.
//
// Vue pour l'ecran de lancement


import SwiftUI
// Structure de la Vue de lancement
struct SplashScreenView: View {
    @EnvironmentObject var viewModel : AppViewModel
    @State private var isActive = false // Variable pour passer a l'ecran suivant
    @State private var size = 0.8 // Variable pour la taille de base de l'image
    @State private var opacity = 0.5 // Variable pour l'opacité de base de l'image
    var body: some View {
        if isActive { // A la fin on affiche la page de connexion
            ContentView()
                .environmentObject(viewModel)
        } else{ // On affiche l'ecran de lancement avec la transition
            VStack{
                VStack{
                    ImageView() // Affichage du logo
                }
                .scaleEffect(size) // On definit la taille de l'image en fonction de notre variable
                .opacity(opacity)// On definit l'opacité de l'image en fonction de notre variable
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9 //On incrémente la taille en avec l'animation
                        self.opacity = 1.0 //On incrémente l'opacité en avec l'animation
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                    withAnimation{ // Animation pour afficher l'ecran de connexion
                        self.isActive = true
                    }
                }
            }
        }
    }
}
//Structure pour le logo
struct LogoView: View{
    var body: some View{
        Image("logo")
            .resizable()
            .frame(width: 450, height: 220)
    }
}
//Preview pour xcode
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
