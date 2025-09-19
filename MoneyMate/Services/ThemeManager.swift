//
//  ThemeManager.swift
//  MoneyMate
//
//  Created by Karan Kumar on 20/09/25.
//


import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
}