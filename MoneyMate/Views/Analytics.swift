//
//  Analytics.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI
import Charts

struct AnalyticsView: View {
    
    @State private var selected = 0
    let durationOptions = ["Week", "Month"]
    
    var body: some View {
        let sampleExpenses: [Expense] = [
            Expense(category: "Food", amount: 120),
            Expense(category: "Travel", amount: 80),
            Expense(category: "Shopping", amount: 200),
            Expense(category: "Bills", amount: 60)
        ]
        
        ScrollView(.vertical, showsIndicators: false) {
            
            // Navigation Bar
            CustomNavigationBarView(selectedTab: .analytics)
            
            VStack(spacing: 20) {
                
                HStack {
                    
                    Spacer()
                    
                    Picker("Options", selection: $selected) {
                        ForEach(0..<durationOptions.count, id: \.self) { index in
                            Text(durationOptions[index])
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 180) // better width
                }
                .padding(.vertical, 8)
                
                Chart(sampleExpenses) { expense in
                    BarMark(
                        x: .value("Category", expense.category),
                        y: .value("Amount", expense.amount)
                    )
                    .foregroundStyle(
                        LinearGradient(colors: [.blue, .purple],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
                }
                .frame(height: 250)
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
            
            
            LazyVGrid(columns: [GridItem(.flexible()),
                                GridItem(.flexible())], spacing: 16){
                ForEach(0...10, id: \.self){ index in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(height: 120)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            VStack(alignment: .leading){
                                
                                HStack{
                                   
                                    Image(systemName: "heart").font(.system(size:20, weight:.bold))
                                        .frame(width: 15, height: 15, alignment: .center)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                
                               
                                Spacer()
                                Text("Card heading").font(.headline)
                                Text("Card heading").font(.caption)
                               
                                
                            }.padding(10)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            
                        )
                    
                }
            }
            
            
        }
        .padding(20)
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        
    }
}

#Preview {
    AnalyticsView()
}
