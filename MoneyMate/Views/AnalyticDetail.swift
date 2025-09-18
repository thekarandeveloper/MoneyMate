//
//  AnalyticDetail.swift
//  MoneyMate
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI
import SwiftData
struct AnalyticDetail: View {
    @Environment(\.modelContext) private var context
      @State private var goToTransactionDetail: Bool = false
      @State private var selectedTransaction: Transaction?

      @Binding var selectedCategoryID: UUID?

      @Query(sort: \Transaction.date, order: .reverse) var allTransactions: [Transaction]

      // Filtered transactions based on selectedCategoryID
      var transactions: [Transaction] {
          guard let catID = selectedCategoryID else { return [] }
          return allTransactions.filter { $0.category?.id == catID }
      }

     
    var body: some View {
        ZStack {
            // Full screen gray background
            Color(red: 246/255, green: 246/255, blue: 246/255)
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(transactions){ tx in
                        
                        TransactionRow(transaction: tx, goToTransactionDetail: $goToTransactionDetail, selectedTransactions: $selectedTransaction)
                        
                    }
                }
                .padding()
            }
          
            .sheet(item: $selectedTransaction){ tx in
                
                NavigationStack {
                    TransactionDetail(transaction: tx)
                }
            }
        }
    }
   

}

private struct TransactionRow: View {
    var transaction: Transaction
    @Binding var goToTransactionDetail: Bool
    @Binding var selectedTransactions: Transaction?
   
    var body: some View {
        Button {
           
            selectedTransactions = transaction
        } label: {
            HStack(spacing: 12) {
                CategoryIcon(transaction: transaction)
                TransactionInfo(transaction: transaction)
                Spacer()
                TransactionAmount(amount: transaction.amount)
            }
            .foregroundStyle(Color.black)
            .padding(.vertical, 8)
        }
    }
}

