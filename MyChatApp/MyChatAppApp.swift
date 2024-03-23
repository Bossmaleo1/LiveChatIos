//
//  MyChatAppApp.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 04/03/2024.
//

import SwiftUI

@main
struct MyChatAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(authVM: AuthViewModel())
        }
    }
}
