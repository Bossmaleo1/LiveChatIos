//
//  ContactRow.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import SwiftUI

struct ContactRow: View {
    var user: AppUser
    var body: some View {
        NavigationLink {
            Text(user.fullName)
        } label: {
            HStack(alignment: .top) {
                Avatar(user: user, size: 50)
                Text(user.fullName)
                    .italic()
                    .bold()
            }
        }
    }
}

#Preview {
    ContactRow(user: AppUser(id: "", dict: [:]))
}
