//
//  AuthViewModel.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 04/03/2024.
//

import Foundation
import SwiftUI
import Firebase

class  AuthViewModel: ObservableObject {
    
    var manager = FirebaseManager.shared
    
    @Published var isFinishedConnecting:Bool =  false
    @Published var isAuth: Bool = false
    @Published var showError: Bool = false
    
    var errorString: String = ""
    var datas: [String: Any] = [:]
    
    
    var auth: Auth {
        return manager.auth
    }
    
    init() {
        observeAuthentication()
    }
    
    func observeAuthentication() {
        auth.addStateDidChangeListener(handleChangeListener)
    }
    
    func handleChangeListener(auth: Auth, user: User?) {
        self.isFinishedConnecting = true
        self.isAuth = user != nil
    }
    
    func signIn(email: String, password: String) {
        guard checkValue(email, value: "adresse mail") else { return }
        guard checkValue(password, value: "mot de passe") else { return }
        auth.signIn(withEmail: email, password: password, completion: completionAuth)
    }
    
  
    
    func createUser(email: String, password: String, name: String, givenName: String) {
        guard checkValue(email, value: "nom") else { return }
        guard checkValue(givenName, value: "prénom") else { return }
        guard checkValue(email, value: "adresse mail") else { return }
        guard checkValue(password, value: "mot de passe") else { return }
        datas = [
            NAME: name,
            GIVEN_NAME: givenName,
            EMAIL: email
        ]
        auth.createUser(withEmail: email, password: password, completion: completionAuth)
    }
    
    func completionAuth(result: AuthDataResult?, error: Error?) {
        if let error = error {
            self.errorString = error.localizedDescription
            self.showError = true
            return
        }
        if let data = result {
            let user = data.user
            let uid = user.uid
            if !datas.isEmpty {
                manager.createUserForFirestore(uid: uid, datas: datas)
                datas = [:]
            }
        }
    }
    
    func checkValue(_ string: String, value: String) -> Bool{
        let isNotEmpty = string != ""
        self.errorString = isNotEmpty ? "" : "Merci d'entrer \(value) pour continuer"
        self.showError = !isNotEmpty
        return isNotEmpty
    }
    
}
