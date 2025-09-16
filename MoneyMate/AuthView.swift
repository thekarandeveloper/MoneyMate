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
                signInWithGoogle()
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
    func signInWithGoogle() {
        // 1. Get the clientID from Firebase config (GoogleService-Info.plist)
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // 2. Create a Google Sign-In configuration using that clientID
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // 3. Get the current app window’s root ViewController (needed to present Google’s sign-in UI)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            return
        }

        // 4. Start the Google Sign-In flow
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { signInResult, error in
            // 5. Handle errors if Google sign-in fails
            if let error = error {
                print("Google Sign-In failed: \(error.localizedDescription)")
                return
            }

            // 6. Get the signed-in Google user and tokens
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else { return }

            let accessToken = user.accessToken.tokenString

            // 7. Convert Google tokens into Firebase credentials
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: accessToken)

            // 8. Sign in to Firebase with those credentials
            Auth.auth().signIn(with: credential) { result, error in
                // 9. Handle Firebase errors
                if let error = error {
                    print("Firebase Sign-In failed: \(error.localizedDescription)")
                    return
                }

                // 10. Success! User is now authenticated with Firebase
                print("User signed in with Google: \(result?.user.uid ?? "")")
                isAuthenticated = true // update binding to move to home screen
            }
        }
    }
}

