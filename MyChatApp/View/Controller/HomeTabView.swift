//
//  HomeTabView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import SwiftUI

struct HomeTabView: View {
    
    @StateObject var userVM = UserViewModel(id: FirebaseManager.shared.myId())
    @State var index: Int = 0
    
    var body: some View {
        TabView(selection: $index) {
            Text("Ici sera nos messages récents écrits")
                .tabItem {
                    Text("Messages")
                    Image(systemName: "message.fill")
                }
            Text("Ici seront tous les utilisateurs")
                .tabItem {
                    Text("Contacts")
                    Image(systemName: "person.circle.fill")
                }
            SettingsView(userVM: userVM)
                .tabItem {
                    Text("Réglages")
                    Image(systemName: "gear")
                }.tag(2)
        }
    }
}

#Preview {
    HomeTabView()
}
