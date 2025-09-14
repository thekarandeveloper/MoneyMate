//
//  CustomNavigationBar.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

struct CustomNavigationBarView:View{
    
    @State var selectedTab: Tab
    
    var body: some View{
      
        
        GeometryReader { geo in
            HStack{
                switch selectedTab {
                case .dashboard:
                    
                    HStack{
                        Image( "Mark").resizable().frame(width: geo.size.width * 0.14, height: geo.size.width * 0.14).clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        VStack(alignment: .leading){
                            Text("Hi, Alex").font(.headline)
                            Text("Welcome Back").font(.caption)
                        }
                    }
                    
                    
                case .transactions:
                    Text("Transactions").font(.largeTitle).fontWeight(.semibold)
                case .settings:
                    Text("Settings").font(.largeTitle).fontWeight(.semibold)
                case .analytics:
                    Text("Analytics").font(.largeTitle).fontWeight(.semibold)
                }
                
       
                Spacer()
                Image(systemName: "bell").font(.system(size: geo.size.width * 0.06, weight: .light))
                    .frame(width: geo.size.width * 0.14, height: geo.size.width * 0.14, alignment: .center)
                    .padding(1).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.5))
            }
        }.frame(height: 60)
        
       
        
       
    }
}

#Preview{
    CustomNavigationBarView(selectedTab: .dashboard)
}
