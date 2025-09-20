//
//  DataModel.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import Foundation
import SwiftUI
import SwiftData
import FirebaseFirestore


@Model
class User:FirestoreModel, Identifiable, Codable {
    @Attribute(.unique) var id: String   // Firebase UID
    var name: String
    var email: String
    var lastUpdated: Date = Date()
    
    // MARK: - Codable conformance
    enum CodingKeys: String, CodingKey {
        case id, name, email, lastUpdated
    }

    // MARK: - Custom init
    init(id: String, name: String, email: String, lastUpdated: Date = Date()) {
        self.id = id
        self.name = name
        self.email = email
        self.lastUpdated = lastUpdated
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.lastUpdated = try container.decode(Date.self, forKey: .lastUpdated)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(lastUpdated, forKey: .lastUpdated)
    }

  
}


@Model
class Transaction: FirestoreModel, Identifiable, Codable {
    @Attribute(.unique) var id: String = UUID().uuidString
    var userID: String
    var amount: Double
    var date: Date
    var note: String?
    var type: String // "income" or "expense"
    var lastUpdated: Date
    var isSynced: Bool
    // Only store categoryId in Firestore (not full Category relationship)
    var categoryId: Int?
    @Relationship(deleteRule: .nullify) var category: Category?

    init(
        userID: String,
        amount: Double,
         date: Date = Date(),
         note: String? = nil,
         type: String,
         category: Category? = nil,
         lastUpdated: Date = Date(),
         isSynced: Bool = false) {
        
             
        self.id = UUID().uuidString
        self.userID = userID
        self.amount = amount
        self.date = date
        self.note = note
        self.type = type
        self.category = category
        self.categoryId = category?.id
        self.lastUpdated = lastUpdated
        self.isSynced = isSynced
    }


    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id, userID, amount, date, note, type, lastUpdated, isSynced, categoryId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        userID = try container.decode(String.self, forKey: .userID)
        amount = try container.decode(Double.self, forKey: .amount)
        date = try container.decode(Date.self, forKey: .date)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        type = try container.decode(String.self, forKey: .type)
        lastUpdated = try container.decode(Date.self, forKey: .lastUpdated)
        isSynced = try container.decode(Bool.self, forKey: .isSynced)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userID, forKey: .userID)
        try container.encode(amount, forKey: .amount)
        try container.encode(date, forKey: .date)
        try container.encode(note, forKey: .note)
        try container.encode(type, forKey: .type)
        try container.encode(lastUpdated, forKey: .lastUpdated)
        try container.encode(isSynced, forKey: .isSynced)
        try container.encode(categoryId, forKey: .categoryId)
    }
}


@Model
class Category: Identifiable, Hashable {
    @Attribute(.unique) var id: Int
    var name: String
    var iconName: String
    
    @Relationship(deleteRule: .nullify) var transactions: [Transaction] = []
    
    // Stored RGB values
    var red: Double = 1.0
    var green: Double = 1.0
    var blue: Double = 1.0
    
    // Computed Color
    var color: Color {
        Color(red: red, green: green, blue: blue)
    }
    
    init(id: Int, name: String, iconName: String, red: Double, green: Double, blue: Double) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    // MARK: - Hashable
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
    let id: Int
    let name: String
    let iconName: String
    let color: Color
}

struct CategoryTotal: Identifiable {
    let id: Int
    let category: Category
    let total: Double
}
struct CategoryRowData: Identifiable {
    let id: Int
    let category: Category
    let total: Double
}
