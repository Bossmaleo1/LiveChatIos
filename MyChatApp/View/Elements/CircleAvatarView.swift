//
//  CircleAvatarView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 29/03/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct CircleAvatarView: View {
    var urlStr: String?
    var size: CGFloat
    
    var body: some View {
        if let urlString = urlStr, let url = URL(string: urlString) {
            WebImage(url: url)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size, alignment: .center)
                .clipShape(Circle())
        } else {
            RemplacementAvatar(size: size)
        }
    }
}

#Preview {
    CircleAvatarView(urlStr: nil, size: 20)
}
