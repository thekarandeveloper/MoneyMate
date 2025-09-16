//
//  OnboardingView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//
import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentPage = 0

    let titles = ["Track Your Expenses", "Set Goals", "Analyze Your Spending"]
    let subtitles = ["Know where your money goes", "Plan better for the future", "Make informed decisions"]

    var body: some View {
        VStack {
            Spacer()
            TabView(selection: $currentPage) {
                ForEach(0..<titles.count, id: \.self) { index in
                    VStack(spacing: 20) {
                        Image(systemName: "dollarsign.circle") // Replace with your images
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.blue)
                        Text(titles[index])
                            .font(.title)
                            .bold()
                        Text(subtitles[index])
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())

            Spacer()
            
            Button(action: {
                if currentPage < titles.count - 1 {
                    currentPage += 1
                } else {
                    hasSeenOnboarding = true
                }
            }) {
                Text(currentPage < titles.count - 1 ? "Next" : "Get Started")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal, 30)
            }
            Spacer()
        }
    }
}
