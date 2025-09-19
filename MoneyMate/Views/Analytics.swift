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
    @State private var selectedCategoryID:UUID? = nil
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
        
        var categoryRows: [CategoryRowData] {
            categories.map { category in
                let total = categoryTotals.first(where: { $0.category.id == category.id })?.total ?? 0
                return CategoryRowData(category: category, total: total)
            }
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
            .background(Color("secondaryBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(categoryRows) { row in
                    Button {
                        selectedCategoryID = row.category.id
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("secondaryBackground"))
                            .frame(height: 120)
                            .overlay(
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(row.category.iconName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .padding(.vertical,10)
                                            .padding(.leading, 0)

                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    Spacer()
                                    
                                    Text(row.category.name).font(.headline)
                                    Text("$\(row.total, specifier: "%.2f")").font(.caption)
                                }
                                .foregroundStyle(Color("Text"))
                                .padding(10)
                            )
                    }
                }
            }
            
            
        }
        .padding(20)
        .background(Color("backgroundColor"))
       
        .navigationDestination(item: $selectedCategoryID){tx in
            
            NavigationStack {
                AnalyticDetail(selectedCategoryID: $selectedCategoryID)
            }
            
        }
      
    }
}
#Preview{
    AnalyticsView()
}
