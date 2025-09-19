//
//  Notification.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI

struct NotificationView: View {
    
    
    
    var body: some View {
        ZStack {
            // Full screen gray background
            Color("backgroundColor")
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    HStack(alignment: .center, spacing: 20) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.2))
                            .overlay(
                                Image(systemName: "bell")
                                    .font(.system(size: 18))
                                    .foregroundColor(.blue)
                            )
                            .frame(width: 50, height: 50)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Notification Title")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Notification Description")
                                .font(.caption)
                                .foregroundColor(Color("secondaryText"))
                            HStack {
                                Spacer()
                                Text("Date")
                                    .font(.caption2)
                                    .foregroundColor(Color("secondaryText"))
                            }
                        }
                    }
                    .padding()
                    .background(Color("secondaryBackground"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding() 
            }
        }
    }
}
#Preview{
    NotificationView()
}
