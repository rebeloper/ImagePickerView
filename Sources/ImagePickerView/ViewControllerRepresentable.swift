import SwiftUI

#if canImport(UIKit)
import UIKit
public typealias PlatformViewControllerRepresentable = UIViewControllerRepresentable
#elseif canImport(AppKit)
import AppKit
public typealias PlatformViewControllerRepresentable = NSViewControllerRepresentable
#endif

/// Provides either `UIViewControllerRepresentable` or `NSViewControllerRepresentable` conformance depending on the target platform;
/// Roughly based on https://gist.github.com/insidegui/97d821ca933c8627e7f614bc1d6b4983
public protocol ViewControllerRepresentable: PlatformViewControllerRepresentable {
    associatedtype ViewControllerType

    func makeViewController(context: Context) -> ViewControllerType
    func updateViewController(_ viewController: ViewControllerType, context: Context)
}


#if canImport(UIKit)
public extension ViewControllerRepresentable where ViewControllerType == UIViewControllerType {
    func makeUIViewController(context: Context) -> UIViewControllerType {
        self.makeViewController(context: context)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        self.updateViewController(uiViewController, context: context)
    }
}
#elseif canImport(AppKit)
public extension ViewControllerRepresentable where ViewControllerType == NSViewControllerType {
    func makeNSViewController(context: Context) -> NSViewControllerType {
        self.makeViewController(context: context)
    }

    func updateNSViewController(_ nsViewController: NSViewControllerType, context: Context) {
        self.updateViewController(nsViewController, context: context)
    }
}
#endif
