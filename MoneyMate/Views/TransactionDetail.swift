//
//  TransactionDetail.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI

struct TransactionDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Transaction Detail")
        VStack{
            
        }.navigationTitle("Transaction Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                // Left Bar Iteam
                ToolbarItem(placement: .cancellationAction){
                    Button("Back"){
                        dismiss()
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
