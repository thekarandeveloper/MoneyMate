//
//  Settings.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "USD"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true

    let currencies = ["USD", "EUR", "INR", "GBP", "JPY"]

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Currency Picker
                Section(header: Text("Currency")) {
                    Picker("Select Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    .pickerStyle(.menu)
                }

                // MARK: - Theme Toggle
                Section(header: Text("Theme")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                    .onChange(of: isDarkMode) { newValue in
                        // Optional: Update app-wide theme dynamically
                        if newValue {
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                        } else {
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                        }
                    }
                }

                // MARK: - Notifications
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                }
            }
            .navigationTitle("Settings")
            .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        }
    }
}

#Preview {
    SettingsView()
}
