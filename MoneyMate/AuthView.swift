//
//  AuthView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//


import SwiftUI
import AuthenticationServices // For Apple Sign-In
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
struct AuthView: View {
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Sign In")
                .font(.largeTitle)
                .bold()
            
            // Apple Sign In Button
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(_):
                        isAuthenticated = true // Replace with real Apple Auth handling
                    case .failure(let error):
                        print("Apple Sign In failed: \(error.localizedDescription)")
                    }
                }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .padding(.horizontal)

            // Google Sign In Button (custom styled for now)
            Button(action: {
//                signInWithGoogle()
            }) {
                HStack {
                    Image(systemName: "g.circle.fill") // placeholder
                        .foregroundColor(.red)
                        .font(.title2)
                    Text("Sign in with Google")
                        .foregroundColor(.black)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }
    func signinwithfirebase(idtoken: String, acessToken: String) {
        let credential = GoogleAuthProvider.credential(withIDToken: idtoken, accessToken: acessToken)
        Auth.auth().signIn(with: credential){authResult, error in
            
            if let error = error{
                print("Firebase signIn failed with", error)
                return
            }
           
            print("User Signed In")
            isAuthenticated = true
        }
    }
   
}

