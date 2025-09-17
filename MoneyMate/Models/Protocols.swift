//
//  Protocols.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//

import Foundation
import FirebaseFirestore

protocol FirestoreModel: Codable, Identifiable{
    var id: String { get set}
    var lastUpdated: Date {get set}
}
