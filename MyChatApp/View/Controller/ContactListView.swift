//
//  ContactListView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import SwiftUI

struct ContactListView: View {
    @StateObject var allUsersVM: AllUsersViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allUsersVM.users) { appUser in
                    ContactRow(user: appUser)
                }
            }
            .navigationTitle("Contacts")
            .listStyle(.plain)
        }
    }
}

#Preview {
    ContactListView(allUsersVM: AllUsersViewModel())
}
