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
    @State private var selectedTransactions: Transaction?
    
    let durationOptions = ["Week", "Month"]
    
    // Swift Data
    @Query(sort: \Transaction.date, order: .reverse) var transactions: [Transaction]
    
    @Query(sort:\Category.name, order: .forward) var categories: [Category]
   
    
    var body: some View {
        
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
        let categoryTotals: [CategoryTotal] = categories.map { category in
            let totalAmount = category.transactions
                .filter { filterTransactions.contains($0) && $0.type == "expense" }
                .map(\.amount)
                .reduce(0,+)
            return CategoryTotal(id: category.id, category: category, total: totalAmount)
        }
        
       
        
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .leading, spacing: 20){
                
                // Navigation Bar
                CustomNavigationBarView(selectedTab:.dashboard)
               
                // Total Balance
                VStack{
                    Text("Wallet Balance")
                        .font(.callout)
                    Text("$\(totalBalance, specifier: "%.2f")")
                        .font(.system(size: 55, weight: .bold, design: .default))
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
                    
                    
                    Chart(categoryTotals) { item in
                        BarMark(
                            x: .value("Category", item.category.name),
                            y: .value("Amount", item.total)
                        )
                        .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                    }.frame(height: 250)
                }.frame(maxWidth: .infinity, maxHeight: 350).padding(20)
                    .background(Color("secondaryBackground"))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                HStack(alignment: .center){
                    Text("Transactions").font(.title3).bold()
                    Spacer()
                    
                    
                    
                }
                
                ForEach(transactions) { transaction in
                    TransactionRow(transaction: transaction,
                                   goToTransactionDetail: $goToTransactionDetail,
                                   selectedTransactions: $selectedTransactions)
                }
            } .padding(.bottom, 50)
        }
        
        .padding(20)
        .padding(.bottom, 50)
        .background(Color("backgroundColor"))
        
        // Navigation Sheets
        
        .navigationDestination(isPresented: $goToDetailAnlytics){
            TransactionView()
                .navigationTitle("All Transactions")
                .navigationBarTitleDisplayMode(.large)
        }
        
        .sheet(item: $selectedTransactions){ tx in
           
            NavigationStack {
                TransactionDetail(transactionID: tx.id)
            }
        }
        
       
       
    }
    
    
   
    
}
private struct TransactionRow: View {
    var transaction: Transaction
    @Binding var goToTransactionDetail: Bool
    @Binding var selectedTransactions: Transaction?
   
    var body: some View {
        Button {
           
            selectedTransactions = transaction
            print(transaction.amount)
        } label: {
            HStack(spacing: 12) {
                CategoryIcon(transaction: transaction)
                TransactionInfo(transaction: transaction)
                Spacer()
                TransactionAmount(amount: transaction.amount)
            }
            .foregroundStyle(Color("Text"))
            .padding(.vertical, 8)
        }
    }
}

struct CategoryIcon: View {
    var transaction: Transaction
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color("secondaryBackground")) // or category color with opacity
                .frame(width: 60, height: 60)

            Image(transaction.category?.iconName ?? "coin") // your asset name
                .resizable()
                .scaledToFit() // keeps aspect ratio
                .frame(width: 32, height: 32) // nice balanced size
                .clipped()
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
