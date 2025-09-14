//
//  ContentView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tab = .dashboard
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            
          
            // Content of selected tab
            Group {
                switch selectedTab {
                case .dashboard:
                    NavigationStack{DashboardView()}
                case .transactions:
                    NavigationStack{TransactionView()}
                case .analytics:
                    NavigationStack{AnalticsView()}
                case .settings:
                    NavigationStack{SettingsView()}
                }
            }.edgesIgnoringSafeArea(.all).background(Color(red: 246/255, green: 246/255, blue: 246/255))
            
            CustomTabbar(selectedTab: $selectedTab)
           
           
        }
       
    }
}

#Preview {
    ContentView()
}
