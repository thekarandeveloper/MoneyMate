//
//  Dashboard.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//


import SwiftUI
import Charts
import SwiftData

struct DashboardView: View{
    
    @State private var selected = 0
    @State private var goToDetailAnlytics: Bool = false
    @State private var goToTransactionDetail:Bool = false
    let durationOptions = ["Week", "Month"]
    
    // Swift Data
    @Query(sort: \Transaction.date, order: .reverse) var transactions: [Transaction]
    
    @Query(sort:\Category.name, order: .forward) var categories: [Category]
   
    
    var body: some View{
        
        // Total Balance
        
        var totalBalance: Double {
            let income = transactions.filter{$0.type == "income"}.map(\.amount).reduce(0,+)
            let expense = transactions.filter{$0.type == "expense"}.map(\.amount).reduce(0,+)
            return income - expense
        }
        
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
        let categoryTotals: [(category: Category, total: Double)] = categories.map {category in
        
            let totalAmount = category.transactions.filter{filterTransactions.contains($0) && $0.type == "expense"}
                
                .map(\.amount).reduce(0,+)
            return (category, totalAmount)
            
        }
        
       
        
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .leading, spacing: 20){
                
                // Navigation Bar
                CustomNavigationBarView(selectedTab:.dashboard)
               
                // Total Balance
                VStack{
                    Text("Wallet Balance")
                        .font(.callout)
                    Text("$\(totalBalance, specifier: "%.2f")").font(.system(size: 55, weight: .bold, design: .default))
                    Text("Last Updated 2 hours ago").font(.caption)
                }.frame(maxWidth: .infinity).padding(20)
             
                
                
                // Income & Expense Graph
                
                VStack(spacing: 20){
                    
                    HStack{
                        Text("Expense Activity").font(.headline)
                        Spacer()
                        Picker("Options", selection: $selected){
                            ForEach(0..<durationOptions.count, id:\.self){ index in
                                Text(durationOptions[index])
                                
                            }
                        }.pickerStyle(.segmented)
                            .frame(width: 150, height: 10, alignment: .trailing)
                            .padding(.vertical, 15)
                        
                    }
                    
                    
                    Chart(categoryTotals, id: \.category.id) { item in
                        BarMark(
                            x: .value("Category", item.category.name),
                            y: .value("Amount", item.total)
                        )
                        .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                    }.frame(height: 250)
                }.frame(maxWidth: .infinity, maxHeight: 350).padding(20)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                HStack(alignment: .center){
                    Text("Recents").font(.title3).bold()
                    Spacer()
                    
                    Button{
                        goToDetailAnlytics = true
                    } label: {
                        Text("View All")
                            .foregroundColor(.blue)
                    }
                    
                }
                
                ForEach(transactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
        }
        
        .padding(20)
        .padding(.bottom, 50)
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        
        // Navigation Sheets
        
        .navigationDestination(isPresented: $goToDetailAnlytics){
            TransactionView()
                .navigationTitle("All Transactions")
                .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $goToTransactionDetail){
            
            NavigationStack{
                TransactionDetail()
                    
            }
            
           
        }
       
    }
}
struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        Button {
            // action
        } label: {
            HStack(spacing: 12) {
                CategoryIcon(transaction: transaction)
                TransactionInfo(transaction: transaction)
                Spacer()
                TransactionAmount(amount: transaction.amount)
            }
            .padding(.vertical, 8)
        }
    }
}

struct CategoryIcon: View {
    var transaction: Transaction
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(width: 60, height: 60)
            Image(systemName: transaction.category?.iconName ?? "bag.fill")
                .font(.system(size: 24))
                .foregroundColor(.black)
        }
    }
}

struct TransactionInfo: View {
    var transaction: Transaction
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(transaction.category?.name ?? "Uncategorized")
                .font(.title3)
                .bold()
            Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
        }
    }
}

struct TransactionAmount: View {
    var amount: Double
    var body: some View {
        HStack(spacing: 4) {
            Text("$\(amount, specifier: "%.2f")")
                .font(.title3)
                .bold()
        }
    }
}

#Preview {
    DashboardView()
}
