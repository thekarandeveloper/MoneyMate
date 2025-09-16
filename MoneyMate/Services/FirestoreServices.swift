//
//  FirestoreServices.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore
import SwiftData


func pushToFirebase(_ tx: Transaction){
    @Environment(\.modelContext) var context

    let db = Firestore.firestore()
    let data: [String: Any] = [
        "id": "\(tx.id)",
        "amount": tx.amount,
        "type": tx.type,
        "date": Timestamp(date: tx.date),
        "categoryId": "\(tx.category?.id)" ?? "",
        "lastUpdated": tx.lastUpdated,
    ]
    
    
    db.collection("transactions").document("\(tx.id)").setData(data){ error in
        if let error = error {
            print("Push failed: \(error)")
        } else {
            print("Pushed transaction \(tx.id)")
            tx.isSynced = true
            try? context.save()
        }
        
    }
    
    
}

func listenForTransactionUpdates(context: ModelContext) {
    print("Started listening")

    let db = Firestore.firestore()
    db.collection("transactions")
        .addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else { return }

            for doc in docs {
                let data = doc.data()
                let id = data["id"] as! String
                let amount = data["amount"] as! Double
                let type = data["type"] as! String
                let date = (data["date"] as! Timestamp).dateValue()
                let lastUpdated = (data["lastUpdated"] as? Timestamp)?.dateValue() ?? Date()

                // ✅ Predicate ko properly likho
                let fetchDescriptor = FetchDescriptor<Transaction>(
                    predicate: #Predicate { "\($0.id)" == id }
                )

                if let localTx = try? context.fetch(fetchDescriptor).first {
                    if localTx.lastUpdated < lastUpdated {
                        localTx.amount = amount
                        localTx.type = type
                        localTx.date = date
                        localTx.lastUpdated = lastUpdated
                        try? context.save()
                    }
                } else {
                    let newTx = Transaction(amount: amount,
                                            date: date,
                                            type: type,
                                            lastUpdated: lastUpdated)
                    context.insert(newTx)
                    try? context.save()
                }
            }
        }
}
