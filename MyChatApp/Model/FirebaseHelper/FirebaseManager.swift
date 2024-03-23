//
//  FirebaseManager.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 04/03/2024.
//

import Foundation
import Firebase
import FirebaseStorage


class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    var auth: Auth
    var storage: Storage
    var cloudFirestore: Firestore
    
    init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        storage = Storage.storage()
        cloudFirestore = Firestore.firestore()
    }
    
    
    var usersRef: CollectionReference {
        return cloudFirestore.collection(USERS)
    }
    
    func userDoc(_ id: String) -> DocumentReference {
        return usersRef.document(id)
    }
    
    func myId() -> String {
        return auth.currentUser?.uid ?? ""
    }
    
    func logOut() {
        do {
            try auth.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createUserForFirestore(uid: String, datas: [String: Any]) {
        let document = usersRef.document(uid)
        document.setData(datas)
    }
    
}
