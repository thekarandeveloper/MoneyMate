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
            }.edgesIgnoringSafeArea(.all).background(Color("backgroundColor"))
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
            await seedDefaultCategory(context: context)
        }
       
    }
}

func seedDefaultCategory(context: ModelContext) async {
    let descriptor = FetchDescriptor<Category>()
    let existingCategories = (try? context.fetch(descriptor)) ?? []

    let defaultCategories: [Category] = [
        Category(name: "Food", iconName: "food", red: 1.0, green: 0.6, blue: 0.0),
        Category(name: "Transport", iconName: "transport", red: 0.6, green: 0.3, blue: 0.0),
        Category(name: "Salary", iconName: "money", red: 0.5, green: 0.0, blue: 0.5)
    ]

    for cat in defaultCategories {
        if !existingCategories.contains(where: { $0.name == cat.name }) {
            context.insert(cat)
        }
    }

    try? context.save() // <-- important for @Query to pick up
}

#Preview {
    ContentView()
}
