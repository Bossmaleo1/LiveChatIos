//
//  ChatMessageListView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import SwiftUI

struct ChatMessageListView: View {
    
    @ObservedObject var messageVM: MessageViewModel
    
    var scrollId = "ScrollId"
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { proxy in
                    VStack {
                        ForEach(messageVM.messages) { message in
                            MessageBubble(message: message, userImageUrl: messageVM.to?._imageUrl)
                        }
                        HStack {
                            Spacer()
                            Spacer(minLength: 150)
                        }.id(scrollId)
                    }
                    .onReceive(messageVM.$count) { output in
                        withAnimation {
                            proxy.scrollTo(scrollId, anchor: .bottom)
                        }
                    }
                }
            }
           
            
        } .safeAreaInset(edge: .bottom) {
            // Zone de texte
            ChatEditingView(vm: messageVM)
        }
        .navigationTitle(messageVM.to?.fullName ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChatMessageListView(messageVM: MessageViewModel(user: AppUser(id: "", dict: [:])))
}
