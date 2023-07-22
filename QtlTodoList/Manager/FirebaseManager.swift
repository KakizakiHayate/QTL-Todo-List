//
//  firebaseManager.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager: ObservableObject {
    // MARK: - Property Wrappers
    @Published var todo = Todos(title: "", message: "")
    // MARK: - Properties
    private let firestore = Firestore.firestore()
    static let shared = FirebaseManager()
    // MARK: - init
    private init() {}
}

extension FirebaseManager {
    // MARK: - Methods
    /// Firestoreにデータ追加
    func createFirestoreData(title: String, message: String) async {
        let todos = Todos(title: "", message: "")
        do {
            try await self.firestore.collection("todos").document(todos.id).setData([
                "title": title,
                "message": message
            ])
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Firestoreのデータ読み込み
    func readFirestoreData() async -> [Todos]?  {
        do {
            let querySnapshot = try await firestore.collection("todos").getDocuments()
            let todos = querySnapshot.documents.map({ queryDocumentSnapshot -> Todos in
                let data = queryDocumentSnapshot.data()
                let title = data["title"] as? String ?? ""
                let message = data["message"] as? String ?? ""
                return Todos(id: queryDocumentSnapshot.documentID, title: title, message: message)
            })
            return todos
        } catch {
            print(error.localizedDescription)
            return nil
        }
     }

    /// FireStoreのデータ更新
    func updateFirestoreData(todo: Todos) async {
        do {
            try await self.firestore.collection("todos").document(todo.id).setData([
                "title": todo.title,
                "message": todo.message
            ])
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Firestoreのデータ削除
    func deleteFirestoreData(todo: Todos) async {
        do {
            try await self.firestore.collection("todos").document(todo.id).delete()
        } catch {
            print(error.localizedDescription)
        }
    }
}
