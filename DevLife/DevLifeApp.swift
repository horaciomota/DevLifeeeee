//
//  DevLifeApp.swift
//  DevLife
//
//  Created by Horacio Mota on 10/11/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var viewModel = CharacterViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .onAppear {
                    // Verifique se o personagem já foi criado ao abrir o aplicativo
                    viewModel.checkCharacterStatus {
                        // Atualize a interface do usuário após verificar o status do personagem
                    }
                }
        }
    }
}
