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
    
    var storageBase: StorageReference {
        return storage.reference()
    }
    
    var storageProfilePics: StorageReference {
        return storageBase.child(USERS)
    }
    
    func userDoc(_ id: String) -> DocumentReference {
        return usersRef.document(id)
    }
    
    func myId() -> String {
        return auth.currentUser?.uid ?? ""
    }
    
    func getId() -> String? {
        return auth.currentUser?.uid
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
    
    func updateUser(key: String, value: Any) {
        guard let uid = getId() else { return }
        userDoc(uid).updateData([key: value])
    }
    
    func updateProfilePicture(image: UIImage?) {
        uploadProfilePicture(image: image) { imageUrl in
            if let url = imageUrl {
                self.updateUser(key: IMAGE_URL, value: url)
            }
            
        }
    }
    
    func uploadProfilePicture(image: UIImage?, completion: @escaping (String?) -> Void) {
        if let image = image {
            if let data = image.jpegData(compressionQuality: 0.25) {
                if let currentId = getId() {
                    let path = storageProfilePics.child(currentId)
                    path.putData(data, metadata: nil) { storage, error in
                        if let error = error {
                            completion(nil)
                        }
                        if let _ = storage {
                            path.downloadURL { url, error in
                                if let error = error {
                                    completion(nil)
                                }
                                completion(url?.absoluteString)
                            }
                        }
                    }
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
}
