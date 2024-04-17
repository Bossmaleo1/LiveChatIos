//
//  Message.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import Foundation

class Message: Identifiable {
    var id: String
    var from: String
    var to: String
    var timeStamp: Double
    var text: String?
    var imageUrl: String?
    var urlLink: String?
    
    init(id: String, dict: [String: Any]) {
        self.id = id
        self.from = dict[FROM] as? String ?? ""
        self.to = dict[TO] as? String ?? ""
        self.timeStamp = dict[TIMESTAMP] as? Double ?? 0.0
        self.text = dict[TEXT] as? String
        self.imageUrl = dict[IMAGE_URL] as? String
        checkLink()
    }
    
    func checkLink() {
        guard text != nil else { return }
        let array = text!.components(separatedBy: " ")
        for word in array {
            if word.hasPrefix("http") || word.contains("www.") {
                self.urlLink = word
            }
        }
    }
}
