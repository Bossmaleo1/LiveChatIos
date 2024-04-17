//
//  ChatEditingView.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import SwiftUI

struct ChatEditingView: View {
    @State var showPicker = false
    @State var isCamera = false
    @FocusState var shouldFocus: Bool
    @ObservedObject var vm: MessageViewModel
    
    var body: some View {
        HStack {
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                Button {
                    self.isCamera = true
                    self.showPicker = true
                } label: {
                    Image(systemName: "camera")
                }
            }
                
            Button {
                    self.isCamera = false
                    self.showPicker = true
            } label: {
                    Image(systemName: "photo.on.rectangle")
            }
            
            TextEditor(text: $vm.newText).frame(height: 40)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.blue, lineWidth: 0.75))
                .focused($shouldFocus)
            
            Button {
                vm.sendMessage()
            } label: {
                Image(systemName: "paperplane")
            }
            
        }
        .padding(4)
        .background(Color(uiColor: UIColor.systemBackground))
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.blue, lineWidth: 0.2))
        .onChange(of: vm.newText) { newValue in
            if newValue == "" {
                self.shouldFocus = false
            }
        }
        .sheet(isPresented: $showPicker) {
            print("Dismissed")
        }
        content: {
            if isCamera {
                ImagePickerRepresentable { newImage in
                    self.vm.newImage = newImage
                    self.vm.sendMessage()
            }
            } else {
                PHPickerRepresentable { newImage in
                    self.vm.newImage = newImage
                    self.vm.sendMessage()
                }
            }
        }
    }
}

