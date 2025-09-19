//
//  MoneyMateApp.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure Firebase at launch
        FirebaseApp.configure()
        NotificationManager.shared.configureRemoteNotifications()
        NotificationManager.shared.requestPermission()
        return true
    }
}

@main
struct MoneyMateApp: App {
    
    @StateObject private var themeManager = ThemeManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
          
            RootView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }.modelContainer(for: [User.self, Transaction.self, Category.self, Goal.self])
    }
    
    
    
    
}

