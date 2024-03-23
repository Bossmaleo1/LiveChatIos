//
//  AppUser.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import Foundation

struct AppUser: Identifiable {
    var id: String
    var _name: String?
    var _givenName: String?
    var _imageUrl: String?
    var _email: String?
    
    var name: String {
        return _name ?? ""
    }
    
    var givenName: String {
        return _givenName ?? ""
    }
    
    var fullName: String {
        return givenName + " " + name
    }
    
    init(id: String, dict: [String: Any]) {
        self.id = id
        self._name = dict[NAME] as? String
        self._givenName = dict[GIVEN_NAME] as? String
        self._email = dict[EMAIL] as? String
        self._imageUrl = dict[IMAGE_URL] as? String
    }
}
