//
//  ContentView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tab = .dashboard
    @State private var showAddScreen = false
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            
          
            // Content of selected tab
            Group {
                switch selectedTab {
                case .dashboard:
                    NavigationStack{DashboardView()}
                case .analytics:
                    NavigationStack{AnalyticsView()}
                case .settings:
                    NavigationStack{SettingsView()}
                case .goals:
                    NavigationStack{SettingsView()}
                }
            }.edgesIgnoringSafeArea(.all).background(Color(red: 246/255, green: 246/255, blue: 246/255))
            VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    showAddScreen = true
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 24, weight: .bold))
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                                }.buttonStyle(PlainButtonStyle())
                                .padding(.trailing, 24)
                                .padding(.bottom, 80) 
                            }
                        }
            CustomTabbar(selectedTab: $selectedTab)
           
           
        }.sheet(isPresented: $showAddScreen){
            NavigationStack{
                NewEntryView()
                    .navigationTitle("New Entry")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        
                        // Left Button
                        
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                showAddScreen = false
                            }
                        }
                        
                        
                        // Right Button
                        
                        ToolbarItem(placement: .confirmationAction){
                            Button("Save"){
                                showAddScreen = false
                            }
                        }
                        
                    }
            }
        }
       
    }
}

#Preview {
    ContentView()
}
