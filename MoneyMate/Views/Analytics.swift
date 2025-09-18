//
//  Analytics.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI
import Charts
import SwiftData
struct AnalyticsView: View {
    
    @State private var selected = 0
    let durationOptions = ["Week", "Month", "Year"]
    
    // Swift Data
    @Query(sort: \Transaction.date, order: .reverse) var transactions: [Transaction]
    @Query(sort: \Category.name, order:.forward) var categories: [Category]
    
    
    
    var body: some View {
        // Category
        
        /// FILTER TRANSACTION ACC. TO DATE
        var filterTransactions: [Transaction] {
            let now = Date()
            
            
            switch selected {
            case 0:
                let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)!
                return transactions.filter{$0.date >= weekAgo}
            case 1:
                let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: now)!
                       return transactions.filter { $0.date >= monthAgo }
            default:
                return transactions
            }
            
        }
        
        // CATEGORIZED FILTERED TRANSACTIONS
        let categoryTotals: [CategoryTotal] = categories.map { category in
            let totalAmount = category.transactions
                .filter { filterTransactions.contains($0) && $0.type == "expense" }
                .map(\.amount)
                .reduce(0,+)
            return CategoryTotal(id: category.id ?? UUID(), category: category, total: totalAmount)
        }
        
        
        ScrollView(.vertical, showsIndicators: false) {
            
            // Navigation Bar
            CustomNavigationBarView(selectedTab: .analytics)
            
            VStack(spacing: 20) {
                
                HStack {
                    Picker("Options", selection: $selected) {
                        ForEach(0..<durationOptions.count, id: \.self) { index in
                            Text(durationOptions[index])
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: .infinity)
                }
                .padding(.vertical, 8)
                
                Chart(categoryTotals) { item in
                    BarMark(
                        x: .value("Category", item.category.name),
                        y: .value("Amount", item.total)
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
                ForEach(0..<categories.count, id: \.self){ index in
                    let category = categories[index]
                           let totalForCategory = categoryTotals.first(where: { $0.category.id == category.id })?.total ?? 0.0
                           
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(height: 120)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            VStack(alignment: .leading){
                                
                                HStack{
                                   
                                    Image(systemName: "\( category.iconName)").font(.system(size:20, weight:.bold))
                                        .frame(width: 15, height: 15, alignment: .center)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                
                                
                                Spacer()
                                Text("\(category.name)").font(.headline)
                                Text("$\(totalForCategory, specifier: "%.2f")")
                                    .font(.caption)
                               
                                
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
