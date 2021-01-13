//
//  ImagePickerView.swift
//  
//
//  Created by Alex Nagy on 13.01.2021.
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct ImagePickerView: UIViewControllerRepresentable {
    
    public init(allowsEditing: Bool = true, delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        self.allowsEditing = allowsEditing
        self.delegate = delegate
    }

    private let delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    private let allowsEditing: Bool
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.allowsEditing = allowsEditing
        controller.delegate = delegate
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) { }
}

@available(iOS 13.0, *)
extension ImagePickerView {
    
    public class Delegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        public init(
            didCancel: @escaping () -> (),
            didSelect: @escaping (UIImage) -> ()) {
            self.didCancel = didCancel
            self.didSelect = didSelect
        }
        
        private let didCancel: () -> ()
        private let didSelect: (UIImage) -> ()
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var selectedImage = UIImage()
            if let editedImage = info[.editedImage] as? UIImage {
                selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                selectedImage = originalImage
            }
            didSelect(selectedImage)
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            didCancel()
        }
    }
    
}


