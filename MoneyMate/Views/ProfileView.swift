//
//  ProfileView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI


struct ProfileView: View{
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View{
     
        VStack {
            Spacer().frame(height: 20)
            avatarView()
            ProfileDetails()
            LogoutButton{
                print("User logged out")
            }.padding()
        }.padding(20)
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .cancellationAction){
                Button("Back"){
                    dismiss()
                }
            }
        }
        
    }
}

struct avatarView: View{
   
    
    var body: some View{
        
        VStack(spacing: 20){
            Image("Mark")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .scaledToFill()
            
            VStack {
                Text("Karan Kumar")
                    .font(.headline)
                Text("Regular")
                    .font(.callout)
            }
           
            
        }
        
    }
    
}

import SwiftUI

struct ProfileDetails: View {
    let personalInfo = [
        ("Name", "Karan Kumar"),
        ("Email", "karan@example.com"),
        ("Phone", "+91 9876543210")
    ]
    
    let workInfo = [
        ("Company", "ABC Pvt Ltd"),
        ("Position", "iOS Developer")
    ]

    var body: some View {
        List {
            Section(header: Text("Personal Info").font(.headline)) {
                ForEach(personalInfo, id: \.0) { item in
                    HStack {
                        Text(item.0) // Question / Label
                            .foregroundColor(.gray)
                        Spacer()
                        Text(item.1) // Answer / Value
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }

            Section(header: Text("Work Info").font(.headline)) {
                ForEach(workInfo, id: \.0) { item in
                    HStack {
                        Text(item.0)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(item.1)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden) // hide default list background
        
    }
}


struct LogoutButton: View {
    var action: () -> Void  // closure to handle logout

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "power")
                    .foregroundColor(.red)
                Text("Logout")
                    .foregroundColor(.red)
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(red: 1, green: 0.9, blue: 0.9))
            .cornerRadius(12)
        }
    }
}

#Preview{
    ProfileView()
}
