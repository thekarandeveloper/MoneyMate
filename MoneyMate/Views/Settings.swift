//
//  Settings.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//
import SwiftUI

struct SettingsView: View{
    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            // Navigation Bar
            CustomNavigationBarView(selectedTab:.settings)
           
        }.padding(20)
    }
}
