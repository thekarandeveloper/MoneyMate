//
//  ProfileView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI
import FirebaseAuth
import SwiftData
struct ProfileView: View{
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View{
     
        VStack {
            Spacer().frame(height: 20)
            avatarView()
            ProfileDetails()
            Spacer()
            LogoutButton{
                logout()
            }.padding()
        }.padding(20)
        .background(Color("backgroundColor"))
        
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
    func logout(){
        do{
            try Auth.auth().signOut()
            print("User Logged Out")
            
        } catch let error as NSError {
            print("Error Siggning out \(error.localizedDescription)")
        }
    }
}

struct avatarView: View{
    @Query var user: [User]
    
    var personalInfo: User {
           if let firstUser = user.first {
               return firstUser
           } else {
              
               return User(id: "0", name: "User Name", email: "example@example.com", lastUpdated: Date())
           }
       }
    var body: some View{
        
       
            VStack(spacing: 20){
                ZStack{
                   Circle()
                        .fill(Color("secondaryBackground"))
                        .frame(width: 100, height: 100)
                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)

                    Image(systemName: "person.fill")
                        .font(.system(size: 34, weight: .medium))
                        .foregroundColor(.blue)
                }
                
                VStack {
                    Text("\(personalInfo.name)")
                        .font(.headline)
                    Text("Joined \(personalInfo.lastUpdated.formatted(date: .abbreviated, time: .omitted))")
                        .font(.callout)
                }
                
            }
            
        
        
       
        
       
    }
    
}

import SwiftUI

struct ProfileDetails: View {
    @Query var user: [User]
    
    var personalInfo: [(String, String)]{
        [
            ("Name", user.first?.name ?? "User Name"),
            ("Email", user.first?.email ?? "Unknown Email")
        ]
    }
    
    
    var body: some View {
        List {
            Section(header: Text("Personal Info").font(.headline)) {
                ForEach(personalInfo, id: \.0) { item in
                    HStack {
                        Text(item.0)
                            .foregroundColor(Color("secondaryText"))
                        Spacer()
                        Text(item.1)
                            .foregroundColor(Color("Text"))
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color("secondaryBackground")) // ← THIS!
                }.background(Color("secondaryBackground"))
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
            .background(Color("secondaryBackground"))
            .cornerRadius(12)
        }
    }
    
   
    
}

#Preview{
    ProfileView()
}
