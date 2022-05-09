//
//  CreateView.swift
//  LazherMeApp
//
//  Created by theo on 09/05/2022.
//

import SwiftUI

struct CreateView: View {
    @State private var favoriteMode = "Team-Deathmatch"
    var modes = ["Team-Deathmatch", "Free-For-All"]
    @State private var favoriteNombre = "2"
    var nombres = ["2", "4", "6", "8", "10", "12"]
    @State private var favoriteTemps = "2"
    var temps = ["10", "20", "30"]
    var body: some View {
        VStack{
            Text("Mode de jeu")
            Picker("Mode de jeu", selection: $favoriteMode) {
                ForEach(modes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            //Text("Value: \(favoriteMode)")
            
            Text("Nombre de joueurs")
            Picker("Nombre de joueurs", selection: $favoriteNombre) {
                ForEach(nombres, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            // Text("Value: \(favoriteNombre)")
            
            Text("Temps")
            Picker("Temps", selection: $favoriteTemps) {
                ForEach(temps, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            // Text("Value: \(favoriteTemps)")
            Button {
                print("Image tapped!")
            } label: {
                CreerBouton()
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
struct CreerBouton: View {
    var body: some View {
        Text("CREER UNE PARTIE")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(.blue)
            .cornerRadius(35.0)
    }
}
