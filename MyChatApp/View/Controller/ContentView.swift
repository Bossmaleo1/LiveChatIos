//
//  ContentView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 04/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authVM: AuthViewModel
    var body: some View {
        if authVM.isFinishedConnecting {
            if authVM.isAuth {
                Button("Deco") {
                    self.authVM.manager.logOut()
                }
            } else {
                LoginView(authVM: authVM)
            }
            
        } else {
            Text("En attente de connection")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    ContentView(authVM: AuthViewModel())
}
