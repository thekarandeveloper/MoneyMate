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
    @Binding var transactionToEdit: Transaction?

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var entrySelected = 0
    @State private var categorySelected = 0
    @State private var newTransactionAmount: String = ""
    @FocusState private var isFocused: Bool
    
    @Query(sort: \Category.id, order: .forward) var categories:[Category]
    
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
                       
                }
            }
            .pickerStyle(.menu)
            
            Spacer()
            
        }
        .padding(15)
        .background(Color("backgroundColor").ignoresSafeArea())
        .navigationTitle("New Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            
            // Right Button
            ToolbarItem(placement: .confirmationAction){
                Button("Save"){
                    let newTx = Transaction(
                        id:transactionToEdit?.id ?? UUID().uuidString,
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
               
            }
            
        }
        
        .onAppear {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                      isFocused = true
                      
                      // Prefill values if editing an existing transaction
                      if let tx = transactionToEdit {
                          newTransactionAmount = "\(tx.amount)"
                          entrySelected = entryType.firstIndex(of: tx.type) ?? 0
                          if let cat = tx.category,
                             let index = categories.firstIndex(where: { $0.id == cat.id }) {
                              categorySelected = index
                          }
                      }
                  }
              }
    }
}
