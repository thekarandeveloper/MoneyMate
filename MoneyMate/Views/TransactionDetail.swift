//
//  TransactionDetail.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI

struct TransactionDetail: View {
    @Environment(\.dismiss) private var dismiss
    @State var transaction: Transaction
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
                Text("\(transaction.amount)")
                    .font(.system(size: 60, weight: .bold))
                
                Divider().frame(maxWidth:200)
             
                Text("\(transaction.date.formatted(date: .abbreviated, time: .shortened))")
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
                        
                        Text("\(transaction.type.capitalized)")
                            .font(.subheadline)
                    }

                    Divider()

                    HStack {
                        Text("Category")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        
                        Text("\(transaction.category)")
                            .font(.subheadline)
                    }

                    Divider()

                    HStack {
                        Text("Amount")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                       
                        Text("\(transaction.amount)")
                            .font(.subheadline)
                            .bold()
                    }

                    Divider()

                    HStack {
                        Text("Date")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(transaction.amount)")
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
//#Preview {
//    TransactionDetail()
//}
