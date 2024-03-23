//
//  SettingsRow.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import SwiftUI

struct SettingsRow: View {
    var imageName: String
    var title: String
    var color: Color
    
    var body: some View {
        NavigationLink {
            if (imageName == "lock.shield") {
                Button("Cliquez ici pour vous déconnecter") {
                    FirebaseManager.shared.logOut()
                }
            } else {
                Text(title)
            }
            
        } label: {
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.white)
                    .padding(3)
                    .background(color)
                    .cornerRadius(25)
                Text(title).italic().bold()
            }.padding(2)
        }
    }
}

#Preview {
    SettingsRow(imageName: "message", title: "Test", color: .red)
}
