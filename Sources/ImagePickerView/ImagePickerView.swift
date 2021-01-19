//
//  ImagePickerView.swift
//  
//
//  Created by Alex Nagy on 19.01.2021.
//

import SwiftUI
import UIKit
import PhotosUI

public struct ImagePickerView: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = PHPickerViewController
    
    public init(filter: PHPickerFilter = .images, selectionLimit: Int = 1, delegate: PHPickerViewControllerDelegate) {
        self.filter = filter
        self.selectionLimit = selectionLimit
        self.delegate = delegate
    }
    
    private let filter: PHPickerFilter
    private let selectionLimit: Int
    private let delegate: PHPickerViewControllerDelegate
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = filter
        configuration.selectionLimit = selectionLimit
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = delegate
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
}

extension ImagePickerView {
    public class Delegate: NSObject, PHPickerViewControllerDelegate {
        
        public init(isPresented: Binding<Bool>, didCancel: @escaping (PHPickerViewController) -> (), didSelect: @escaping (ImagePickerResult) -> ()) {
            self._isPresented = isPresented
            self.didCancel = didCancel
            self.didSelect = didSelect
        }
        
        @Binding var isPresented: Bool
        private let didCancel: (PHPickerViewController) -> ()
        private let didSelect: (ImagePickerResult) -> ()
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            var images = [UIImage]()
            for i in 0..<results.count {
                let result = results[i]
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { newImage, error in
                        if let error = error {
                            print("Can't load image \(error.localizedDescription)")
                        } else if let image = newImage as? UIImage {
                            images.append(image)
                        }
                        
                        if i >= results.count - 1 {
                            self.isPresented = false
                            if images.count != 0 {
                                self.didSelect(ImagePickerResult(picker: picker, images: images))
                            } else {
                                self.didCancel(picker)
                            }
                        }
                    }
                } else {
                    print("Can't load asset")
                    
                    if i >= results.count - 1 {
                        self.isPresented = false
                        if images.count != 0 {
                            self.didSelect(ImagePickerResult(picker: picker, images: images))
                        } else {
                            self.didCancel(picker)
                        }
                    }
                }
            }
            
            
        }
    }
}

public struct ImagePickerResult {
    public let picker: PHPickerViewController
    public let images: [UIImage]
}
