//
//  Dashboard.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//


import SwiftUI
import Charts

struct DashboardView: View{
    var body: some View{
        let fruits = ["Apple", "Banana", "Mango"]
        let sampleExpenses: [Expense] = [
            Expense(category: "Food", amount: 120),
            Expense(category: "Travel", amount: 80),
            Expense(category: "Shopping", amount: 200),
            Expense(category: "Bills", amount: 60)
        ]
        VStack(alignment: .leading, spacing: 20){
            
            // Total Balance
            VStack{
                Text("Wallet Balance")
                    .font(.callout)
                Text("$12129.56").font(.system(size: 55, weight: .bold, design: .default))
                Text("Last Updated 2 hours ago").font(.caption)
            }.frame(maxWidth: .infinity).padding(20)
            Spacer().frame(height: 10)
            
            
            // Income & Expense Graph
            
            VStack{
                Chart(sampleExpenses){ expense in
                    BarMark(
                        x: .value("Category", expense.category),
                        y: .value("Amount", expense.amount),
                    )
                }
            }.frame(maxWidth: .infinity, maxHeight: 250).padding(20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            HStack(alignment: .center){
                Text("Recent Expenses").font(.title3).bold()
                Spacer()
                Text("View All")
            }
            
            ForEach(fruits, id:\.self){ fruit in
                HStack{
                    Image(systemName: "heart")
                    VStack(alignment: .leading){
                        Text("\(fruit.capitalized)").font(.title3).bold()
                        Spacer()
                        Text("August 23, 2003")
                    }
                    Spacer()
                    HStack{
                        Text("$123").font(.title3).bold()
                        Image(systemName: "chevron.right")
                        
                    }
                }.frame(height: 50)
            }
            
            
           
            
        }.padding(20)
            .background(Color.gray.opacity(0.3))
       
    }
}


#Preview {
    DashboardView()
}
