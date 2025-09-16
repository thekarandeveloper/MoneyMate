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
    
    var totalBalance: Double {
        let income = transactions.filter{$0.type == "income"}.map(\.amount).reduce(0,+)
        let expense = transactions.filter{$0.type == "expense"}.map(\.amount).reduce(0,+)
        return income - expense
    }
    
    var body: some View{
        
        let categories: [CategoryItem] = [
            CategoryItem(name: "Food", iconName: "fork.knife", color: .red),
            CategoryItem(name: "Travel", iconName: "car.fill", color: .blue),
            CategoryItem(name: "Shopping", iconName: "bag.fill", color: .purple),
            CategoryItem(name: "Bills", iconName: "doc.text.fill", color: .green)
        ]
        let sampleExpenses: [Expense] = [
            Expense(category: "Food", amount: 120),
            Expense(category: "Travel", amount: 80),
            Expense(category: "Shopping", amount: 200),
            Expense(category: "Bills", amount: 60)
        ]
        
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
                        Text("Activity").font(.headline)
                        Spacer()
                        Picker("Options", selection: $selected){
                            ForEach(0..<durationOptions.count, id:\.self){ index in
                                Text(durationOptions[index])
                                
                            }
                        }.pickerStyle(.segmented)
                            .frame(width: 150, height: 10, alignment: .trailing)
                            .padding(.vertical, 15)
                        
                    }
                    
                    
                    Chart(sampleExpenses){ expense in
                        BarMark(
                            x: .value("Category", expense.category),
                            y: .value("Amount", expense.amount),
                        ).foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)).cornerRadius(10)
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
                
                ForEach(categories, id:\.self) { category in
                    
                    Button{
                        goToTransactionDetail = true
                    } label: {
                        HStack(alignment: .center, spacing: 12) {
                            
                            // Icon with background
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color.white)
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: category.iconName)
                                    .font(.system(size: 24))
                                    .foregroundColor(category.color)
                            }
                            
                            // Text info
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.name.capitalized)  // fixed typo ..capitalized
                                    .font(.title3)
                                    .bold()
                                Text("August 23, 2003")
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            // Amount + chevron
                            HStack(spacing: 4) {
                                Text("$123")  // replace with category.amount if needed
                                    .font(.title3)
                                    .bold()
                            }
                        }
                        .foregroundStyle(Color.black)
                        .padding(.vertical, 8)
                    
                    }
                   
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
                    .navigationTitle("Transaction Detail")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        
                        // Left Bar Iteam
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                goToTransactionDetail = false
                            }
                        }
                        
                        
                        // Right Bar Button
                        
                        ToolbarItem(placement: .confirmationAction) {
                                           Button {
                                              // SHare Logic
                                           } label: {
                                               Image(systemName: "square.and.arrow.up")
                                           }
                                       }
                        
                    }
            }
            
           
        }
       
    }
}


#Preview {
    DashboardView()
}
