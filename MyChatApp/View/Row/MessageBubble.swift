//
//  MessageBubble.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 29/03/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageBubble: View {
    var message: Message
    
    let fromColor = Color.teal
    let toColor = Color.green
    let userImageUrl: String?
    let manager = FirebaseManager.shared
    @State var shouldRedraw = true
    
    func isMe() -> Bool {
        return message.from == manager.myId()
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            if isMe() {
                Spacer(minLength: 50)
            } else {
                CircleAvatarView(urlStr: userImageUrl, size: 40)
            }
            VStack(alignment: .trailing) {
                if message.imageUrl != nil {
                    WebImage(url: URL(string: message.imageUrl!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                }
                if message.text != nil {
                    Text(message.text!)
                        .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
                        .background(isMe() ? fromColor : toColor)
                        .foregroundColor(isMe() ? .white : .black)
                        .cornerRadius(20)
                }
                
                if let urlString = message.urlLink , let url = URL(string: urlString) {
                    LinkViewRepresentable(previewUrl: url, shouldRedraw: $shouldRedraw)
                }
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
            
            if !isMe() {
                Spacer(minLength: 150)
            }
            
        }.padding(.horizontal)
    }
}

#Preview {
    MessageBubble(message: Message(id: "3", dict: [:]), userImageUrl: nil)
}
