//
//  SettingsView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var userVM: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    VStack {
                        Image("cover")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                        HStack {
                            Spacer(minLength: 80)
                            Text(userVM.user?.fullName ?? "")
                                .italic()
                                .bold()
                                .padding(.horizontal)
                        }
                        .frame(height: 40)
                        
                        //Spacer(minLength: 80)
                    }
                    Avatar(size: 80).padding(.horizontal)
                }
                Divider()
                List {
                    Section("Informations") {
                        
                    }
                    Section("Réglages de l'app") {
                        SettingsRow(imageName: "paperplane", title: "Envois", color: .purple)
                        SettingsRow(imageName: "bell", title: "Notifications", color: .red)
                        SettingsRow(imageName: "shield", title: "Confidentialité", color: .green)
                    }
                    Section("Paramètres") {
                        SettingsRow(imageName: "doc", title: "Mentions Légales", color: .gray)
                        SettingsRow(imageName: "gear", title: "Paramètres du compte", color: .gray)
                        SettingsRow(imageName: "questionmark", title: "Aide", color: .blue)
                        SettingsRow(imageName: "lock.shield", title: "Se Déconnecter", color: .red)
                    }
                }
                Spacer()
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

#Preview {
    SettingsView(userVM: UserViewModel(id: FirebaseManager.shared.myId()))
}
