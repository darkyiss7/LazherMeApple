//
//  LazherMeAppApp.swift
//  LazherMeApp
//
//  Created by theo on 23/03/2022.
//

import SwiftUI
import Firebase
@main
struct LazherMeAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
    class AppDelegate: NSObject,UIApplicationDelegate{
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
    }

}
