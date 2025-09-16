//
//  New.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI

struct NewEntryView: View{
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var entrySelected = 0
    @State private var categorySelected = 0
    @State private var newTransactionAmount: Double = 0.0
    @FocusState private var isFocused: Bool
    let entryType = ["expense", "income"]
    let category = ["Rent", "Misc", "karan", "food", "transport", "salary"]
    var body: some View{
        
        VStack(alignment: .center, spacing: 20){
            
            // Entry Type Picker
            
            Picker("selection", selection: $entrySelected){
                ForEach(0..<entryType.count, id:\.self){ index in
                    
                    Text(entryType[index])
                    
                }
            }.pickerStyle(.segmented)
            Spacer().frame(maxHeight: 20)
            HStack(alignment: .center, spacing: 0){
                Text("$").font(.system(size: 60, weight: .bold))
                TextField("0.0", value:$newTransactionAmount, format: .number)
                    .font(.system(size: 60, weight: .bold))
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.decimalPad).focused($isFocused)
                    .fixedSize()
                    
            }.frame(maxWidth: .infinity, alignment: .center)
            
            Divider()
                .frame(width: 200)
            Picker("categorySelection", selection: $categorySelected){
                ForEach(0..<category.count, id:\.self){
                    index in
                    Text(category[index])
                }
            }
            
            
            Spacer()
            
            
            
        }.padding(15)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                isFocused = true
            }
        }
        .navigationTitle("New Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            
            // Left Button
            
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){
                   dismiss()
                }
            }
            
            
            // Right Button
            
            ToolbarItem(placement: .confirmationAction){
                Button("Save"){
                    
                    let newTx = Transaction(amount: newTransactionAmount, category: category[categorySelected], type: entryType[entrySelected])
                    
                    context.insert(newTx)
                    try? context.save()
                    
                    
                    dismiss()
                }
            }
            
        }
        
       
        
        
    }
       
}

#Preview{
    NewEntryView()
}
