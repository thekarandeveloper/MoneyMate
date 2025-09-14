//
//  DataModel.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//
import SwiftUI

struct Expense: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}
