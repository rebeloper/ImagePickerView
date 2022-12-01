//
//  ImagePickerView.swift
//  
//
//  Created by Alex Nagy on 19.01.2021.
//

import SwiftUI
import PhotosUI

#if canImport(UIKit)
import UIKit
public typealias PHImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias PHImage = NSImage
#endif


public struct ImagePickerView: ViewControllerRepresentable {
    
    public typealias ViewControllerType = PHPickerViewController
    
    public init(filter: PHPickerFilter = .images, selectionLimit: Int = 1, delegate: PHPickerViewControllerDelegate) {
        self.filter = filter
        self.selectionLimit = selectionLimit
        self.delegate = delegate
    }
    
    private let filter: PHPickerFilter
    private let selectionLimit: Int
    private let delegate: PHPickerViewControllerDelegate
    
    public func makeViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = filter
        configuration.selectionLimit = selectionLimit
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = delegate
        return controller
    }
    
    public func updateViewController(_ viewController: PHPickerViewController, context: Context) { }
}

extension ImagePickerView {
    public class Delegate: NSObject, PHPickerViewControllerDelegate {
        
        public init(isPresented: Binding<Bool>, didCancel: @escaping (PHPickerViewController) -> (), didSelect: @escaping (ImagePickerResult) -> (), didFail: @escaping (ImagePickerError) -> ()) {
            self._isPresented = isPresented
            self.didCancel = didCancel
            self.didSelect = didSelect
            self.didFail = didFail
        }
        
        @Binding var isPresented: Bool
        private let didCancel: (PHPickerViewController) -> ()
        private let didSelect: (ImagePickerResult) -> ()
        private let didFail: (ImagePickerError) -> ()
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if results.count == 0 {
                self.isPresented = false
                self.didCancel(picker)
                return
            }
            var images = [ImagePickerResult.SelectedImage]()
            for i in 0..<results.count {
                let result = results[i]
                if result.itemProvider.canLoadObject(ofClass: PHImage.self) {
                    result.itemProvider.loadObject(ofClass: PHImage.self) { newImage, error in
                        if let error = error {
                            self.isPresented = false
                            self.didFail(ImagePickerError(picker: picker, error: error))
                        } else if let image = newImage as? PHImage {
                            images.append(.init(index: i, image: image))
                        }
                        if images.count == results.count {
                            self.isPresented = false
                            if images.count != 0 {
                                self.didSelect(ImagePickerResult(picker: picker, images: images))
                            } else {
                                self.didCancel(picker)
                            }
                        }
                    }
                } else {
                    self.isPresented = false
                    self.didFail(ImagePickerError(picker: picker, error: ImagePickerViewError.cannotLoadObject))
                }
            }
            
            
        }
    }
}

public struct ImagePickerResult {
    public let picker: PHPickerViewController
    public let images: [SelectedImage]

    public struct SelectedImage {
        public let index: Int
        public let image: PHImage
    }
}

public struct ImagePickerError {
    public let picker: PHPickerViewController
    public let error: Error
}

public enum ImagePickerViewError: Error {
    case cannotLoadObject
    case failedToLoadObject
}
