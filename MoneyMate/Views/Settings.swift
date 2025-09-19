//
//  Settings.swift
//  MoneyMate
//
//  Created by Karan Kumar on 14/09/25.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Theme Toggle
                Section(header: Text("Theme")) {
                    Toggle(isOn: $themeManager.isDarkMode) {
                        Text("Dark Mode")
                    }.listRowBackground(Color("secondaryBackground"))
                }

                // MARK: - Notifications
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                }.listRowBackground(Color("secondaryBackground"))
                
            }
            
            .scrollContentBackground(.hidden)
            .background(Color("backgroundColor"))
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
