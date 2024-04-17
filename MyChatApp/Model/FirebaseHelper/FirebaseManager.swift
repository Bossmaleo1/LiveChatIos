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
    
    var messagesRef: CollectionReference {
        return cloudFirestore.collection(MESSAGES)
    }
    
    var storageBase: StorageReference {
        return storage.reference()
    }
    
    var storageProfilePics: StorageReference {
        return storageBase.child(USERS)
    }
    
    var storageMessages: StorageReference {
        return storageBase.child(MESSAGES)
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
        guard let image = image else { return }
        guard let data = image.jpegData(compressionQuality: 0.25) else { return }
        guard let currentId = getId() else { return }
        let ref = storageProfilePics.child(currentId)
        uploadPicture(ref: ref, data: data) { imageUrl in
            if let url = imageUrl {
                self.updateUser(key: IMAGE_URL, value: url)
            }
        }
    }
    
    func addImagetoChat(image: UIImage?, completion: @escaping (String?) -> Void) {
        guard let image = image else { completion(nil); return }
        guard let data = image.jpegData(compressionQuality: 0.25) else { completion(nil); return }
        guard let id = getId() else { return }
        let ref = storageMessages.child(id).child(String(Date().timeIntervalSince1970))
        uploadPicture(ref: ref, data: data) { urlString in
            completion(urlString)
        }
    }
    
    func setUpPathForMessage(from: String, to: String) -> CollectionReference {
        let array = [from, to]
        let sortedArray = array.sorted(by: {$0 < $1})
        let first = sortedArray[0]
        let second = sortedArray[1]
        let ref = messagesRef.document(first).collection(second)
        return ref
    }
    
    func sendMessage(from: String, to: String, dict: [String:Any], image: UIImage?) {
        var newDict = dict
        let newDocument = setUpPathForMessage(from: from, to: to).document()
        addImagetoChat(image: image) { url in
            if let urlstring = url {
                newDict[IMAGE_URL] = urlstring
            }
            newDocument.setData(newDict)
        }
    }
    
    func uploadPicture(ref: StorageReference,data: Data, completion: @escaping (String?) -> Void) {
        ref.putData(data, metadata: nil) { storage, error in
            if let error = error {
                print(error)
                completion(nil)
            }
            if let _ = storage {
                ref.downloadURL { url, error in
                    if let error = error {
                        print(error)
                        completion(nil)
                    }
                    completion(url?.absoluteString)
                }
            }
        }
        
    }
    
}
