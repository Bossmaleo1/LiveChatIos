//
//  UserViewModel.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    @Published var user: AppUser?
    var manager = FirebaseManager.shared
    
    init(id: String) {
        getUserWithId(id)
    }
    
    func getUserWithId(_ id: String) {
        manager.userDoc(id).addSnapshotListener(result)
    }
    
    func result(_ snapshot: DocumentSnapshot?, error: Error?) {
        DispatchQueue.main.async {
            guard let snap = snapshot else { return }
            let id = snap.documentID
            let datas = snap.data() ?? [:]
            let newUser = AppUser(id: id, dict: datas)
            self.user = newUser
        }
    }
}
