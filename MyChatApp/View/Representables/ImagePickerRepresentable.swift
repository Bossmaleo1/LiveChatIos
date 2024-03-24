//
//  ImagePickerRepresentable.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 24/03/2024.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePickerRepresentable: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var isPres
    let image: (UIImage?) -> Void
    
    init(image: @escaping (UIImage?) -> Void) {
        self.image = image
    }
    
    func dismiss() {
        isPres.wrappedValue.dismiss()
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(image: image, dismiss: dismiss)
        
    }
    
    class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let dismiss: () -> Void
        let image: (UIImage?) -> Void
        
        init(image: @escaping(UIImage?)-> Void, dismiss: @escaping () -> Void) {
            self.image = image
            self.dismiss = dismiss
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let new = info[.originalImage] as? UIImage {
                self.image(new)
            }
            dismiss()
        }
        
    }
}
