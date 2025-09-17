//
//  RootView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//
import SwiftUI
import FirebaseAuth

struct RootView: View {
    @State private var isAuthenticated = Auth.auth().currentUser != nil
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
            } else {
                if isAuthenticated {
                    ContentView()
                } else {
                    OnboardingView(isAuthenticated: $isAuthenticated)
                }
            }
        }
        .onAppear {
            // 🔹 Splash hide after 2 sec
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { showSplash = false }
            }
            
            // 🔹 Firebase auth state listener
            Auth.auth().addStateDidChangeListener { _, user in
                withAnimation {
                    isAuthenticated = user != nil
                }
            }
        }
    }
}
