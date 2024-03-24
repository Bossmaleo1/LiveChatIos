//
//  AllUsersViewModel.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import Foundation
import Firebase

class AllUsersViewModel: ObservableObject {
    @Published var users: [AppUser] = []
    var manager = FirebaseManager.shared
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        manager.usersRef.addSnapshotListener(result)
    }
    
    func result(query: QuerySnapshot?, error: Error?) {
        DispatchQueue.main.async {
            self.users = []
            if let error = error {
                print(error.localizedDescription)
            }
            if let all = query?.documents {
                let myId = self.manager.myId()
                all.forEach { snapshot in
                    let id = snapshot.documentID
                    let dict = snapshot.data()
                    let newUser = AppUser(id: id, dict: dict)
                    if myId != id {
                        self.users.append(newUser)
                    }
                }
            }
        }
    }
    
}
