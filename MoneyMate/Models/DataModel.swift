//
//  DataModel.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//
import SwiftUI
import SwiftData



@Model
class Transaction{
    @Attribute var id : UUID = UUID()
    var amount: Double
        var category: String
        var date: Date = Date()
        var note: String?
        var type: String // "income" or "expense"
    
    init(amount:Double, category: String, date: Date = Date(), note: String? = nil, type: String){
        self.id = UUID()
        self.amount = amount
        self.category = category
        self.date = Date()
        self.note = note
        self.type = type
    }
    
}

@Model
class Category {
    @Attribute(.unique) var id: UUID
    var name: String
    var iconName: String
    var colorHex: String
    
    init(name: String, iconName: String, colorHex: String) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.colorHex = colorHex
    }
}

@Model
class Goal {
    @Attribute(.unique) var id: UUID
    var targetAmount: Double
    var currentAmount: Double
    var deadline: Date
    
    init(targetAmount: Double, currentAmount: Double, deadline: Date) {
        self.id = UUID()
        self.targetAmount = targetAmount
        self.currentAmount = currentAmount
        self.deadline = deadline
    }
}


// Simple Transactions
struct Expense: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}


struct CategoryItem: Hashable {
    let id = UUID()
    let name: String
    let iconName: String
    let color: Color
}
