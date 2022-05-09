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
            Text("Creer une partie")
                .font(.largeTitle)
                .padding(.bottom,50.0)
            HStack{
                Text("Mode de jeu")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                Picker("Mode de jeu", selection: $favoriteMode) {
                    ForEach(modes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .padding(.trailing,30.0)
                .padding(.bottom , 20.0)
            }
            
            //Text("Value: \(favoriteMode)")
            HStack{
                Text("Nombre de joueurs")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                Picker("Nombre de joueurs", selection: $favoriteNombre) {
                    ForEach(nombres, id: \.self) {
                        Text($0)
                            .font(.system(size: 15.0))
                    }
                }
                .pickerStyle(.menu)
                .padding(.trailing,70.0)
                .padding(.bottom , 20.0)
            }
            
            // Text("Value: \(favoriteNombre)")
            HStack{
                Text("Temps")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                Picker("Temps", selection: $favoriteTemps) {
                    ForEach(temps, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .padding(.trailing,70.0)
                // Text("Value: \(favoriteTemps)")
                
            }
            .padding(.bottom,40.0)
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
        
        Text("CREER")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(purpleDark)
    }
}
