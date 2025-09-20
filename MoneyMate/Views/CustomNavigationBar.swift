//
//  CustomNavigationBar.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI
import SwiftData
struct CustomNavigationBarView: View {
    
    @State var selectedTab: Tab
    @State private var goToProfile = false
    @State private var goToNotification = false
    @Query var user: [User]
    var body: some View {
        HStack {
            switch selectedTab {
            case .dashboard:
                Button {
                    goToProfile = true
                } label: {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("secondaryBackground"))
                                .frame(width: 50, height: 50)
                                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)

                            Image(systemName: "person.fill")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.blue) // icon ka main color
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Hi, \(user.first?.name ?? "User")").font(.headline).foregroundStyle(Color("Text"))
                            Text("Welcome Back").font(.caption).foregroundStyle(Color("Text"))
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
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("secondaryBackground"))
                        .frame(width: 50, height: 50)
                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)

                    Image(systemName: "person.fill")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.blue) 
                }
               
            }
        }
        .frame(height: 60)
        
        // Attach Screens
        .sheet(isPresented: $goToProfile){
            
            NavigationStack{
                
                ProfileView()
                    .presentationDragIndicator(.visible)
            }
         
        }
        .navigationDestination(isPresented: $goToNotification) {
            NotificationView()
                .navigationTitle("Notification View")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
