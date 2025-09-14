//
//  Transactions.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

struct TransactionView: View{
    let fruits = ["Apple", "Banana", "Mango"]
    let sampleExpenses: [Expense] = [
        Expense(category: "Food", amount: 120),
        Expense(category: "Travel", amount: 80),
        Expense(category: "Shopping", amount: 200),
        Expense(category: "Bills", amount: 60)
    ]
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
            // Navigation Bar
            CustomNavigationBarView(selectedTab:.transactions)
            
            Spacer().frame(height: 20)
            
            // Lists
            VStack(spacing: 20){
                ForEach(fruits, id:\.self){ fruit in
                    HStack(alignment: .top){
                        Image( "Mark").resizable().frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        VStack(alignment: .leading){
                            Text("\(fruit.capitalized)").font(.title3).bold()
                           
                            Text("August 23, 2003").font(.caption)
                            Spacer()
                        }
                        Spacer()
                        HStack{
                            Text("$123").font(.title3).bold()
                            Image(systemName: "chevron.right")
                            
                        }
                    }.frame(height: 60)
                }
            }
           
            
        }.padding(20)
        
       
    }
}

#Preview {
    TransactionView()
}
