//
//  Avatar.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 23/03/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct Avatar: View {
    @State var showActionSheet = false
    @State var showSheet = false
    @State var isCamera = false
    
    var user: AppUser?
    var size: CGFloat
    
    var body: some View {
  
        
        Button {
            if isMe() {
                self.showActionSheet = true
            }
        } label: {
            CircleAvatarView(urlStr: user?._imageUrl, size: size)
        }
        
       // RemplacementAvatar(size: size)
            .sheet(isPresented: $showSheet, onDismiss: {
                print("Dismiss")
            }, content: {
                if UIImagePickerController.isSourceTypeAvailable(.camera) && self.isCamera {
                    ImagePickerRepresentable { img in
                        FirebaseManager.shared
                            .updateProfilePicture(image: img)
                    }
                } else {
                    PHPickerRepresentable { img in
                        FirebaseManager.shared
                            .updateProfilePicture(image: img)
                    }
                }
            })
            .confirmationDialog("Changer l'image", isPresented: $showActionSheet, actions: {
                Button("Camera") {
                    self.isCamera = true
                    if isMe() {
                        self.showSheet = true
                    }
                }
                
                Button("Librairie") {
                    self.isCamera = false
                    if isMe() {
                        self.showSheet = true
                    }
                }
            })
    }
    
    func isMe() -> Bool {
        if let u =  user {
            if let id = FirebaseManager.shared.getId() {
                if u.id == FirebaseManager.shared.getId() {
                    return u.id == id
                }
            }
        }
        return false
    }
}

#Preview {
    Avatar(size: 20)
}
