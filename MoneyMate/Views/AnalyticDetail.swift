//
//  AnalyticDetail.swift
//  MoneyMate
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

    // Filtered transactions for this category
    var transactions: [Transaction] {
        guard let catID = selectedCategoryID else { return [] }
        return allTransactions.filter { $0.category?.id == catID }
    }

    // Dynamic category name for navigation title
    var categoryName: String {
        guard let catID = selectedCategoryID else { return "Category" }
        return categories.first(where: { $0.id == catID })?.name ?? "Category"
    }

    // Generate all dates of current month
    var daysInMonth:  [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        var dates: [Date] = []
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: -i, to: today) {
                dates.append(day)
            }
        }
        
        return dates.reversed() // Optional: earliest day first
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {

                        // MARK: - Chart
                        if !transactions.isEmpty {
                            Chart(transactions) { tx in
                                BarMark(
                                    x: .value("Day", Calendar.current.startOfDay(for: tx.date)),
                                    y: .value("Amount", tx.amount)
                                )
                                .foregroundStyle(tx.type == "income" ? .green : .red)
                            }
                            .chartXAxis {
                                AxisMarks(values: daysInMonth) { value in
                                    AxisGridLine()
                                    AxisTick()
                                    AxisValueLabel() {
                                        if let date = value.as(Date.self) {
                                            Text(date.formatted(.dateTime.day(.defaultDigits)))
                                        }
                                    }
                                }
                            }
                            .chartYAxis {
                                AxisMarks() { value in
                                    AxisGridLine()
                                    AxisTick()
                                    AxisValueLabel()
                                }
                            }
                            .frame(height: 250)
                            .padding()
                            .background(Color("secondaryBackground"))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }

                        // MARK: - Transaction List
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(transactions) { tx in
                                Button {
                                    selectedTransaction = tx
                                } label: {
                                    HStack {
                                        Text(tx.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.subheadline)
                                            .foregroundColor(Color("secondaryText"))
                                        Spacer()
                                        Text("₹\(tx.amount, specifier: "%.2f")")
                                            .font(.headline)
                                            .foregroundColor(tx.type == "income" ? .green : .red)
                                    }
                                    .padding()
                                    .background(Color("secondaryBackground"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }

                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
            }
            .navigationTitle(categoryName)
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedTransaction) { tx in
                NavigationStack {
                    TransactionDetail(transaction: tx)
                }
            }
        }
    }
}

#Preview {
    // Example usage with dummy binding
    AnalyticDetail(selectedCategoryID: .constant(UUID()))
}
