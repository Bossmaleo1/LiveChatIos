//
//  MessageViewModel.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import Firebase
import UIKit

class MessageViewModel: ObservableObject {
    @Published var count = 0
    @Published var messages: [Message] = []
    @Published var newText = ""
    @Published var newImage: UIImage?
    var to: AppUser?
    let manager = FirebaseManager.shared
    
    init(user: AppUser) {
        self.to = user
        getMessages()
    }
    
    func getMessages() {
        guard let myId = manager.getId() else { return }
        guard let toId = to?.id else { return }
        manager.setUpPathForMessage(from: myId, to: toId)
            .order(by: TIMESTAMP)
            .addSnapshotListener(handleResult)
    }
    
    func handleResult(query: QuerySnapshot?, error: Error?) {
        DispatchQueue.main.async {
            if let q = query {
                q.documentChanges.forEach { doc in
                    let newDoc = doc.document
                    let message = Message(id: newDoc.documentID, dict: newDoc.data())
                    self.messages.append(message)
                }
                self.count += 1
            }
        }
    }
    
    func sendMessage() {
        guard newText != "" || newImage != nil else { return }
        guard let from = manager.getId() else { return }
        guard let toId = to?.id else { return }
        let dict = createDict(from: from, to: toId)
        manager.sendMessage(from: from, to: toId, dict: dict, image: newImage)
        // Envoyer dans Furebase
        self.newText = ""
        self.newImage = nil
    }
    
    func createDict(from: String, to: String) -> [String: Any] {
        var dict: [String: Any] = [
            FROM: from,
            TO: to,
            TIMESTAMP: Date().timeIntervalSince1970
        ]
        
        if newText != "" {
            dict[TEXT] = newText
        }
        return dict
    }
}
