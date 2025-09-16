//
//  ContentView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    
    @State private var selectedTab: Tab = .dashboard
    @State private var showAddScreen = false
    @Environment(\.modelContext) private var context
   
    @Query(sort: \Category.name) var categories: [Category]
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
           
           
        }
       
        .sheet(isPresented: $showAddScreen){
            NavigationStack{
                NewEntryView()
                    
            }
        }.task {
            
            // Create Default Category
            
            seedDefaultCategory(context: context)
            listenForTransactionUpdates(context: context)
            
        }
       
    }
}

func seedDefaultCategory(context: ModelContext){
    // Fetch Existing Categories
    
    let descriptor = FetchDescriptor<Category>() // fetch all Category
    let existingCategories = (try? context.fetch(descriptor)) ?? []
    
    
    let defaultCategories: [Category] = [
        Category(name: "Food", iconName: "fork.knife", red: 1.0, green: 0.6, blue: 0.0),      // orange
        Category(name: "Transport", iconName: "car.fill", red: 0.6, green: 0.3, blue: 0.0),   // brown
        Category(name: "Salary", iconName: "banknote.fill", red: 0.5, green: 0.0, blue: 0.5)   // purple
    ]
    
    for cat in defaultCategories {
        print("Entered in function")
        if !existingCategories.contains(where: {$0.name == cat.name}){
            context.insert(cat)
            print("Creating", cat.name)
        }
    }
    
    try? context.save()
    
    
}

#Preview {
    ContentView()
}
