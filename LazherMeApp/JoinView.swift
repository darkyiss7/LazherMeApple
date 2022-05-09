//
//  JoinView.swift
//  LazherMeApp
//
//  Created by theo on 09/05/2022.
//

import SwiftUI

struct JoinView: View {
    @State var code: String = ""
    var body: some View {
        CodeTextField(code: $code)
            .padding(.bottom, 0.0)
        NavigationLink(destination: BLEScan()){
                RejoindreBouton()
                .padding(.bottom, 0.0)
        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView()
    }
}
struct RejoindreBouton: View {
    var body: some View {
        Text("REJOINDRE UNE PARTIE")
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .frame(width: 240, height: 60)
            .background(.blue)
            .cornerRadius(35.0)
    }
}

