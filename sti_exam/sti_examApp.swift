//
//  sti_examApp.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-01-08.
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
struct sti_examApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authViewAdapter = AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: "")
    @StateObject private var homeViewAdapter = HomeViewAdapter()
    
    var body: some Scene {
        WindowGroup {
            if let user = authViewAdapter.currentUser {
                NavigationStack {
                    HomeView(authViewAdapter: authViewAdapter, homeViewAdapter: homeViewAdapter)
                }
                
            } else {
                NavigationStack {
                    LoginView(authViewAdapter: authViewAdapter, homeViewAdapter: homeViewAdapter)
                }
                
            }
        }
    }
}
