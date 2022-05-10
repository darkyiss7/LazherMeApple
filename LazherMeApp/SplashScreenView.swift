//
//  SplashScreenView.swift
//  LazherMeApp
//
//  Created by theo on 09/05/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var viewModel : AppViewModel
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(viewModel)
        } else{
            VStack{
                VStack{
                    ImageView()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}
struct LogoView: View{
    var body: some View{
        Image("logo")
            .resizable()
            .frame(width: 450, height: 220)
    }
}
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
