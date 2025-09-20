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
        ZStack {
                    Color("backgroundColor")
                        .ignoresSafeArea() 

                    VStack {
                        VStack{
                           
                            // Transaction Category
                            
                            VStack(alignment: .center, spacing: 10){
                                
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Image("\(transaction.category?.iconName ?? "coin")")
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                           
                                    )
                                Text("\(transaction.amount, specifier:"%.2f")")
                                    .font(.system(size: 60, weight: .bold))
                                
                                Divider().frame(maxWidth:200)
                             
                                Text("\(transaction.date.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.system(size: 16, weight: .regular))
                                
                                Spacer().frame(maxHeight: 40)
                                
                                
                                
                                // Details Table
                                
                                
                                VStack(alignment: .center, spacing: 16) {
                                    Text("Transaction Details")
                                        .foregroundStyle(Color("secondaryText").opacity(0.7))
                                        .font(.headline)
                                        .padding(.bottom, 12)

                                    HStack {
                                        Text("Type")
                                            .font(.subheadline)
                                            .foregroundColor(Color("secondaryText"))
                                        Spacer()
                                        
                                        Text("\(transaction.type.capitalized)")
                                            .font(.subheadline)
                                    }

                                    Divider()

                                    HStack {
                                        Text("Category")
                                            .font(.subheadline)
                                            .foregroundColor(Color("secondaryText"))
                                        Spacer()
                                        if let category = transaction.category?.name {
                                            Text(category)
                                                .font(.subheadline)
                                        } else {
                                            Text("Uncategorized")
                                                .font(.subheadline)
                                                .foregroundColor(Color("secondaryText"))
                                        }
                                       
                                    }

                                    Divider()

                                    HStack {
                                        Text("Amount")
                                            .font(.subheadline)
                                            .foregroundColor(Color("secondaryText"))
                                        Spacer()
                                       
                                        Text("\(transaction.amount)")
                                            .font(.subheadline)
                                            .bold()
                                    }

                                    Divider()
                                    HStack {
                                        Text("Modified Date")
                                            .font(.subheadline)
                                            .foregroundColor(Color("secondaryText"))
                                        Spacer()
                                        
                                        Text("\(transaction.date.formatted(date: .abbreviated, time: .omitted))")
                                            .font(.subheadline)
                                    }
                                    Divider()
                                    HStack {
                                        Text("Created Date")
                                            .font(.subheadline)
                                            .foregroundColor(Color("secondaryText"))
                                        Spacer()
                                        Text("\(transaction.date.formatted(date: .abbreviated, time: .omitted))")
                                            .font(.subheadline)
                                    }
                                 
                                }
                                .padding()
                                .background(Color("secondaryBackground"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color("secondaryText").opacity(0.3), lineWidth: 1)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                .padding(.horizontal)
                                
                                Spacer()
                                
                                Button {
                                    // Open edit sheet
                                } label: {
                                    
                                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                                        .frame(maxWidth: .infinity, maxHeight: 70).overlay(
                                            Text("Edit Transaction")
                                                .foregroundColor(.white)
                                        )
                                }
                                
                              
                                
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    .padding(20)
                }
      
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
