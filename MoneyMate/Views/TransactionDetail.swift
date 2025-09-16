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
        
        VStack{
           
            // Transaction Category
            
            VStack(alignment: .center, spacing: 10){
                
                Circle()
                    .fill(Color.pink.opacity(0.1)) // background directly circle ke andar
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "heart")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.pink)
                    )
                Text("$10,000")
                    .font(.system(size: 60, weight: .bold))
                
                Divider().frame(maxWidth:200)
                
                Text("24 August, 2025")
                    .font(.system(size: 20, weight: .regular))
                
                Spacer().frame(maxHeight: 40)
                
                
                
                // Details Table
                
                
                VStack(alignment: .center, spacing: 16) {
                    Text("Transaction Details")
                        .foregroundStyle(Color.gray.opacity(0.7))
                        .font(.headline)
                        .padding(.bottom, 12)

                    HStack {
                        Text("Type")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Expense")
                            .font(.subheadline)
                    }

                    Divider()

                    HStack {
                        Text("Category")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Food")
                            .font(.subheadline)
                    }

                    Divider()

                    HStack {
                        Text("Amount")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("$120.00")
                            .font(.subheadline)
                            .bold()
                    }

                    Divider()

                    HStack {
                        Text("Date")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("16 Sep 2025")
                            .font(.subheadline)
                    }
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    // Open edit sheet
                } label: {
                    
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .frame(maxWidth: .infinity, maxHeight: 60).overlay(
                            Text("Edit Transaction")
                                .foregroundColor(.white)
                        )
                }
                
              
                
            }
            
            
            
            
        }
        .padding(20)
        .navigationTitle("Transaction Detail")
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
#Preview {
    TransactionDetail()
}
