//
//  Avatar.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import SwiftUI

struct Avatar: View {
    var size: CGFloat
    
    var body: some View {
        RemplacementAvatar(size: size)
    }
}

#Preview {
    Avatar(size: 20)
}
