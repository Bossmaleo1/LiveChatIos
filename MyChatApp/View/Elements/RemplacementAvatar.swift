//
//  RemplacementAvatar.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import SwiftUI

struct RemplacementAvatar: View {
    var size: CGFloat
    
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .foregroundColor(.secondary)
            .frame(width: size, height: size, alignment: .center)
            .background(Color(uiColor: UIColor.systemBackground))
            .clipShape(Circle())
        
    }
}

#Preview {
    RemplacementAvatar(size: 20)
}
