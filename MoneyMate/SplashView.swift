//
//  SplashView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack {
                Image("AppLogo") // your logo
                    .resizable()
                    .frame(width: 150, height: 150)
                Text("MoneyMate")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}
