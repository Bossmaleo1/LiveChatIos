//
//  SettingsView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var userVM: UserViewModel
    @State var prenom : String = ""
    @State var nom: String = ""
    
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
                    Avatar(user: userVM.user,size: 80).padding(.horizontal)
                }
                Divider()
                List {
                    Section("Informations") {
                        HStack {
                            TextField(userVM.user?.givenName ?? "Prénom", text: $prenom)
                                .textFieldStyle(.roundedBorder)
                            Button {
                                if self.prenom != "" {
                                    userVM.manager.updateUser(key: GIVEN_NAME, value: self.prenom)
                                }
                                self.prenom = ""
                            } label: {
                                Image(systemName: "plus")
                                    .padding(3)
                                    .foregroundColor(.primary)
                                    .background(Color.secondary.opacity(0.4))
                                    .clipShape(Circle())
                            }
                        }
                        
                        HStack {
                            TextField(userVM.user?.name ?? "Nom", text: $nom)
                                .textFieldStyle(.roundedBorder)
                            Button {
                                if self.nom != "" {
                                    userVM.manager.updateUser(key: NAME, value: self.nom)
                                }
                                self.nom = ""
                            } label: {
                                Image(systemName: "plus")
                                    .padding(3)
                                    .foregroundColor(.primary)
                                    .background(Color.secondary.opacity(0.4))
                                    .clipShape(Circle())
                            }
                        }
                        
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
