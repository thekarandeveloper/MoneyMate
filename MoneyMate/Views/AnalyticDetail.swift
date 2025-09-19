//
//  AnalyticDetail.swift
//  MoneyMate
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI
import SwiftData
import Charts

struct AnalyticDetail: View {
    @Environment(\.modelContext) private var context
    @State private var selectedTransaction: Transaction?

    @Binding var selectedCategoryID: UUID?

    @Query(sort: \Transaction.date, order: .reverse) var allTransactions: [Transaction]
    @Query(sort: \Category.name, order: .forward) var categories: [Category]

    // Filtered transactions
    var transactions: [Transaction] {
        guard let catID = selectedCategoryID else { return [] }
        return allTransactions.filter { $0.category?.id == catID }
    }

    // Get category name
    var categoryName: String {
        guard let catID = selectedCategoryID else { return "Category" }
        return categories.first(where: { $0.id == catID })?.name ?? "Category"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        // MARK: - Chart: Date vs Amount
                        if !transactions.isEmpty {
                            Chart(transactions) { tx in
                                BarMark(
                                    x: .value("Date", tx.date),
                                    y: .value("Amount", tx.amount)
                                )
                                .foregroundStyle(tx.type == "income" ? .green : .red)
                                .symbol(Circle())
                                .interpolationMethod(.catmullRom)
                            }
                            .frame(height: 240)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                           
                        }

                        // MARK: - List of Transactions
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(transactions) { tx in
                                Button {
                                    selectedTransaction = tx
                                } label: {
                                    HStack {
                                        Text(tx.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.subheadline)
                                            .foregroundColor(.gray)

                                        Spacer()

                                        Text("₹\(tx.amount, specifier: "%.2f")")
                                            .font(.headline)
                                            .foregroundColor(tx.type == "income" ? .green : .red)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                }
                            }
                        }
                       
                    }
                    .padding(.top)
                }.padding(20)
                .navigationTitle(categoryName) // Dynamic title = category name
                .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(item: $selectedTransaction) { tx in
                NavigationStack {
                    TransactionDetail(transaction: tx)
                }
            }
        }
    }
}
