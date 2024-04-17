//
//  LinkRepresentable.swift
//  MyChatApp
//
//  Created by Sidney MALEO on 17/04/2024.
//

import SwiftUI
import LinkPresentation

struct LinkViewRepresentable: UIViewRepresentable {
    var previewUrl: URL
    @Binding var shouldRedraw: Bool
    
    func makeUIView(context: Context) -> some LPLinkView {
        let linkView = LPLinkView(url: previewUrl)
        let metadataProvider = LPMetadataProvider()
        metadataProvider.startFetchingMetadata(for: previewUrl) { linkMetadata, err in
            if let error = err {
                print(error.localizedDescription)
                let replacementMeta = LPLinkMetadata()
                replacementMeta.title = previewUrl.absoluteString
                linkView.sizeToFit()
                self.shouldRedraw.toggle()
            }
            
            if let linkMeta = linkMetadata {
                DispatchQueue.main.async {
                    linkView.metadata = linkMeta
                    linkView.sizeToFit()
                    self.shouldRedraw.toggle()
                }
            }
        }
        return linkView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        self.shouldRedraw.toggle()
    }
    
}
