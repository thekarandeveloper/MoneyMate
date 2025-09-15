//
//  CustomTabbar.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

enum Tab{
    case dashboard
    case goals
    case analytics
    case settings
}

struct CustomTabbar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack{
            tabButton(.dashboard, icon: "house.fill", title: "Home")
            Spacer()
           
           tabButton(.analytics, icon: "chart.bar.fill", title: "Analytics")
           Spacer()
            tabButton(.goals, icon: "checkmark.seal.fill", title: "Goals")
           Spacer()
           tabButton(.settings, icon: "gearshape.fill", title: "Settings")
        }.padding().background(Color.white)
    }
    
    func tabButton(_ tab: Tab, icon:String, title:String) -> some View {
        Button(action: {
            
            withAnimation(.spring()){
                selectedTab = tab
            }
            }){
            VStack{
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .bold))
                Text(title)
                    .font(.caption)
            }.foregroundColor(selectedTab == tab ? .blue : .gray)
        }
    }
    
}
