//
//  OnboardingView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//
import SwiftUI
import AuthenticationServices
struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentPage = 0
    let images = ["First", "Second", "Third"]
    let titles = ["Track Your Expenses", "Set Goals", "Analyze Your Spending"]
    let subtitles = ["Know where your money goes", "Plan better for the future", "Make informed decisions"]

    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer().frame(maxHeight: 30)
            
            TabView(selection: $currentPage){
                ForEach(0..<titles.count, id:\.self){ index in
                    
                    VStack(spacing: 20) {
                        Image(images[index])
                            .resizable()
                            .scaledToFit() // keeps aspect ratio, no stretch
                            .frame(maxHeight: 300)
                            .foregroundColor(.blue)
                            .transition(.slide) // slide transition
                            .animation(.easeInOut, value: currentPage)
                        
                        Text(titles[index])
                            .font(.title)
                            .bold()
                            .transition(.opacity.combined(with: .scale))
                            .animation(.easeInOut, value: currentPage)
                        
                        Text(subtitles[index])
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .transition(.opacity)
                            .animation(.easeInOut, value: currentPage)
                                }
                                .tag(index)

                }
            }
            .frame(maxHeight: 500)
            .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onReceive(timer){ _ in
                    withAnimation{
                        currentPage = (currentPage + 1) % titles.count
                    }
                    
                }
            
          
            Spacer().frame(maxHeight: 30)
            
            
            
            // Apple Sign In Button
            SignInWithAppleButton(.signIn){ request in
                request.requestedScopes = [.fullName, .email]
                
            } onCompletion: { result in
                print(result)
            }.signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .frame(maxWidth: .infinity) // full width
//                           .cornerRadius(8)
//                           .padding(10)
                           .padding(.horizontal, 20)
            // 🔹 Google Sign In
                        Button {
                            // handle Google sign in
                            print("Google tapped")
                        } label: {
                            HStack {
                                Image(systemName: "g.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title2)
                                Text("Sign in with Google")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity) // full width
                            .padding()
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray, lineWidth: 1)
                            )
                            .cornerRadius(10)
                            
                        }
                        .padding(.horizontal, 20)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
