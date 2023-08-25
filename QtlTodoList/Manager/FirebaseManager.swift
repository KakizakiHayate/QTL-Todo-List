//
//  firebaseManager.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import SwiftUI

final class FirebaseManager: ObservableObject {
    // MARK: - Property Wrappers
    @Published var todo = Todos(title: "", message: "", uploadUrl: "")
    // MARK: - Properties
    private let firestore = Firestore.firestore()
    static let shared = FirebaseManager()
    private let storage = Storage.storage()
    // MARK: - init
    private init() {}
}

extension FirebaseManager {
    // MARK: - Methods
    /// Firestoreにデータ追加
    func createFirestoreData(title: String, message: String, imageUrl: URL?) async {
        let todos = Todos(title: "", message: "", uploadUrl: "")
        do {
            try await self.firestore.collection("todos").document(todos.id).setData([
                "title": title,
                "message": message,
                "uploadUrl": imageUrl?.absoluteString ?? ""
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
                let uploadUrl = data["uploadUrl"] as? String ?? ""
                return Todos(id: queryDocumentSnapshot.documentID, title: title, message: message, uploadUrl: uploadUrl)
            })
            return todos
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// FireStoreのデータ更新
    func updateFirestoreData(todo: Todos, uploadUrl: URL?) async {
        do {
            try await self.firestore.collection("todos").document(todo.id).setData([
                "title": todo.title,
                "message": todo.message,
                "uploadUrl": uploadUrl?.absoluteString ?? ""
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
    
    /// 画像アップロード
    func todoImageUpload(image: UIImage) async -> URL? {
        let reference = storage.reference().child("image/image\(UUID().uuidString).jpg")
        guard let resizedImage = image.resizeUIImage(width: image.size.width, height: image.size.height) else {
            return nil
        }
        guard let data = resizedImage.jpegData(compressionQuality: 0.2) else { return nil }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        do {
            let _ = try await reference.putDataAsync(data)
            let dowloadUrl = try await reference.downloadURL()
            return dowloadUrl
        } catch {
            print("Error while uploading file: ", error)
            return nil
        }
    }
}
