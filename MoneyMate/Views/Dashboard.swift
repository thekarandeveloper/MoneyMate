//
//  Dashboard.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//


import SwiftUI
import Charts

struct DashboardView: View{
    
    @State private var selected = 0
    let durationOptions = ["Week", "Month"]
    
    var body: some View{
        
        
        
        
        
        let fruits = ["Apple", "Banana", "Mango"]
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
                    Text("$12129.56").font(.system(size: 55, weight: .bold, design: .default))
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
                    Text("Recent Expenses").font(.title3).bold()
                    Spacer()
                    Text("View All")
                }
                
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
                    }.frame(height: 50)
                }
                
                
               
                
            }
        }
        
        .padding(20)
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
            
       
    }
}


#Preview {
    DashboardView()
}
