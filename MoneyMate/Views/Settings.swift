//
//  Settings.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//
import SwiftUI

struct SettingsView: View{
    let fruits = ["Apple", "Banana", "Mango"]
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
            // Navigation Bar
            CustomNavigationBarView(selectedTab:.settings)
            
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
                        }
                    }.frame(height: 60)
                }
            }
           
            
        }.padding(20)
    }
}
