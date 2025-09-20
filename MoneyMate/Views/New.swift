//
//  New.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct NewEntryView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var entrySelected = 0
    @State private var categorySelected = 0
    @State private var newTransactionAmount: String = ""
    @FocusState private var isFocused: Bool
    
    @Query(sort: \Category.name, order: .forward) var categories:[Category]
    
    let entryType = ["expense", "income"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            
            // Entry Type Picker
            Picker("selection", selection: $entrySelected){
                ForEach(0..<entryType.count, id:\.self){ index in
                    Text(entryType[index].capitalized)
                        .foregroundColor(Color("Text"))
                }
            }
            .pickerStyle(.segmented)
            .accentColor(Color("secondaryColor"))
            
            Spacer().frame(maxHeight: 20)
            
            // Amount Input
            HStack(alignment: .center, spacing: 0){
                Text("$")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color("Text"))
                
                TextField("0.0", text:$newTransactionAmount)
                    .font(.system(size: 60, weight: .bold))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                    .foregroundColor(Color("Text"))
                    .fixedSize()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Divider()
                .frame(width: 200)
                .background(Color("secondaryColor"))
            
            // Category Picker
            Picker("categorySelection", selection: $categorySelected){
                ForEach(0..<categories.count, id:\.self){ index in
                    Text(categories[index].name)
                        .foregroundColor(Color("Text"))
                }
            }
            .pickerStyle(.menu)
            .accentColor(Color("secondaryColor"))
            
            Spacer()
            
        }
        .padding(15)
        .background(Color("backgroundColor").ignoresSafeArea())
        .navigationTitle("New Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            
            // Left Button
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){
                   dismiss()
                }
                .foregroundColor(Color("secondaryText"))
            }
            
            // Right Button
            ToolbarItem(placement: .confirmationAction){
                Button("Save"){
                    let newTx = Transaction(
                        userID: Auth.auth().currentUser?.uid ?? "unknownUserID",
                        amount: Double(newTransactionAmount) ?? 0.0,
                        type: entryType[entrySelected],
                        category: categories[categorySelected]
                    )
                    
                    Task{
                        await FirestoreManager.shared.save(newTx, in: "transactions", context: context)
                    }
                    
                    dismiss()
                }
                .foregroundColor(Color("secondaryText"))
            }
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                isFocused = true
            }
        }
    }
}
