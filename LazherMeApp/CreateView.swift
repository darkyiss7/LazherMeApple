//
//  CreateView.swift
//  LazherMeApp
//
//  Created by theo on 09/05/2022.
//

import SwiftUI

struct CreateView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
