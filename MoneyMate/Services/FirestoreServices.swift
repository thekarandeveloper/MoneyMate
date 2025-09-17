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

@MainActor
class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    // Mark: - Create / Update
    
    func save<T: FirestoreModel & PersistentModel>(_ model: T, in collection: String, context: ModelContext) async{
        do{
            
            // Save on Server
            let data = try Firestore.Encoder().encode(model)
            try await db.collection(collection).document(model.id).setData(data)
            
            
            // Save Locally
            context.insert(model)
            try? context.save()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Read
    
    func fetch<T: FirestoreModel & PersistentModel>(_ type: T.Type, from collection: String, context: ModelContext) async -> [T] {
        do{
            let snapshot = try await db.collection(collection).getDocuments()
            let models = try snapshot.documents.compactMap{doc in
                try doc.data(as: T.self)
            }
            
            
            // Save Locally
            models.forEach{context.insert($0)}
            try? context.save()
            return models
        } catch {
            print("Error fetching: \(error.localizedDescription)")
            return []
        }
    }
    // MARK: - Delete
        func delete<T: FirestoreModel & PersistentModel>(_ model: T, from collection: String, context: ModelContext) async {
            do {
                try await db.collection(collection).document(model.id).delete()
                context.delete(model)
                try? context.save()
            } catch {
                print("❌ Error deleting: \(error.localizedDescription)")
            }
        }
        
        // MARK: - Real-time Sync
        func listen<T: FirestoreModel & PersistentModel>(_ type: T.Type, in collection: String, context: ModelContext) {
            db.collection(collection).addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                
                for doc in docs {
                    do {
                        let remoteModel = try doc.data(as: T.self)
                        
                        // Check if exists locally
                        if let local = try? context.fetch(FetchDescriptor<T>(predicate: #Predicate { $0.id == remoteModel.id })).first {
                            if local.lastUpdated < remoteModel.lastUpdated {
                                // 🔄 Update local
                                context.delete(local)
                                context.insert(remoteModel)
                            }
                        } else {
                            // 🔄 Insert new
                            context.insert(remoteModel)
                        }
                    } catch {
                        print("❌ Error decoding: \(error.localizedDescription)")
                    }
                }
                try? context.save()
            }
        }
}

