//
//  CustomNavigationBar.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

struct CustomNavigationBarView: View {
    
    @State var selectedTab: Tab
    @State private var goToProfile = false
    @State private var goToNotification = false
    
    var body: some View {
        HStack {
            switch selectedTab {
            case .dashboard:
                Button {
                    goToProfile = true
                } label: {
                    HStack {
                        Image("Mark")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading) {
                            Text("Hi, Alex").font(.headline).foregroundStyle(.black)
                            Text("Welcome Back").font(.caption).foregroundStyle(.black)
                        }
                    }
                }
                
         
            case .settings:
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            case .analytics:
                Text("Analytics")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            case .goals:
                Text("Goals")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Button {
                goToNotification = true
            } label: {
                Image(systemName: "bell")
                    .foregroundStyle(.black)
                    .font(.system(size: 24, weight: .light))
                    .frame(width: 50, height: 50)
                    .padding(1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
            }
        }
        .frame(height: 60)
        
        // Attach Screens
        .sheet(isPresented: $goToProfile){
            ProfileView()
                .presentationDragIndicator(.visible)
        }
        .navigationDestination(isPresented: $goToNotification) {
            NotificationView()
                .navigationTitle("Analytics")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {   
        CustomNavigationBarView(selectedTab: .dashboard)
    }
}
#Preview{
    CustomNavigationBarView(selectedTab: .dashboard)
}
