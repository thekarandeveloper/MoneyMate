//
//  Transactions.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

struct TransactionView: View{

    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            // Navigation Bar
            CustomNavigationBarView(selectedTab:.transactions)
           
        }.padding(20)
    }
}
