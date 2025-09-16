//
//  MoneyMateApp.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//

import SwiftUI

@main
struct MoneyMateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [Transaction.self, Category.self, Goal.self])
    }
}
