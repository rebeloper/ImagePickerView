# 🌇 ImagePickerView

![swift v5.3](https://img.shields.io/badge/swift-v5.3-orange.svg)
![platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)
![deployment target iOS 14](https://img.shields.io/badge/deployment%20target-iOS%2014-blueviolet)
![YouTube tutorial](https://img.shields.io/badge/YouTube-video%20tutorial-red)

**ImagePickerView** is a lightweight library which brings `PHPickerViewController` / `UIImagePickerController` to `SwiftUI`.

## 💻 Installation
### 📦 Swift Package Manager
Using <a href="https://swift.org/package-manager/" rel="nofollow">Swift Package Manager</a>, add it as a Swift Package in Xcode 11.0 or later, `select File > Swift Packages > Add Package Dependency...` and add the repository URL:
```
https://github.com/rebeloper/NavigationKit.git
```
### ✊ Manual Installation
Download and include the `ImagePickerView` folder and files in your codebase.

### 📲 Requirements
- iOS 14+
- Swift 5.3+

## 👉 Import

Import `ImagePickerView` into your `View`

```
import ImagePickerView
```

## 🧳 Features

Here's the list of the awesome features `ImagePickerView` has:
- [X] use `PHPickerViewController` as a `View` in `SwiftUI` projects (recommended, introduced in `iOS14`)
- [X] use `UIImagePickerController` as a `View` in `SwiftUI` projects (not-recommended; use only for single image picking and when you want to enable editing) 
- [X] set `filter` and `selectionLimit` in `ImagePickerView`
- [X] `didCancel`, `didSelect` and `didFail` delegate callbacks for `ImagePickerView`
- [X] set `allowsEditing` in `UIImagePickerView`
- [X] `didCancel` and `didSelect` delegate callbacks for `UIImagePickerView`

## 💻 How to Use

Selecting images from our iPhone library is needed when changing a profile picture, posting an update, or sharing the photo of your pet. In `UIKit` `Pre-iOS14` we would use `UIImagePickerController`, but as of `iOS14` Apple introduced `PHPickerViewController`. 
`ImagePickerView` supports both of them:
`UIImagePickerController` -> `UIImagePickerView`
`PHPickerViewController` -> `ImagePickerView`

Just check out these examples where the `UIImagePickerView`/`ImagePickerView` is presented upon a tap of a `Button`. 

## `UIImagePickerView`

```
import SwiftUI
import ImagePickerView

struct UIImagePickerControllerContentView: View {
    
    @State var isImagePickerViewPresented = false
    @State var pickedImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            Text("UIImagePickerView").font(.largeTitle)
            
            Button {
                isImagePickerViewPresented = true
            } label: {
                VStack {
                    if pickedImage == nil {
                        Image(systemName: "camera")
                            .font(.largeTitle)
                    } else {
                        Image(uiImage: pickedImage!)
                            .resizable()
                            .frame(width: 66, height: 66)
                            .cornerRadius(33)
                    }
                }
            }
            .sheet(isPresented: $isImagePickerViewPresented) {
                UIImagePickerView(allowsEditing: true, delegate: UIImagePickerView.Delegate(isPresented: $isImagePickerViewPresented, didCancel: { (uiImagePickerController) in
                    print("Did Cancel: \(uiImagePickerController)")
                }, didSelect: { (result) in
                    let uiImagePickerController = result.picker
                    let image = result.image
                    print("Did Select image: \(image) from \(uiImagePickerController)")
                    pickedImage = image
                }))
            }
            
            Spacer()
        }
    }
}
```

## `ImagePickerView`

```
import SwiftUI
import ImagePickerView

struct PHPickerViewControllerContentView: View {
    
    @State var isImagePickerViewPresented = false
    @State var pickedImages: [UIImage]? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            Text("ImagePickerView").font(.largeTitle)
            
            Button {
                isImagePickerViewPresented = true
            } label: {
                VStack {
                    Image(systemName: "camera")
                        .font(.largeTitle)
                }
            }
            .sheet(isPresented: $isImagePickerViewPresented) {
                // filter default is .images; please DO NOT CHOOSE .videos
                // selectionLimit default is 1; set to 0 to have unlimited selection
                ImagePickerView(filter: .any(of: [.images, .livePhotos]), selectionLimit: 0, delegate: ImagePickerView.Delegate(isPresented: $isImagePickerViewPresented, didCancel: { (phPickerViewController) in
                    print("Did Cancel: \(phPickerViewController)")
                }, didSelect: { (result) in
                    let phPickerViewController = result.picker
                    let images = result.images
                    print("Did Select images: \(images) from \(phPickerViewController)")
                    pickedImages = images
                }, didFail: { (imagePickerError) in
                    let phPickerViewController = imagePickerError.picker
                    let error = imagePickerError.error
                    print("Did Fail with error: \(error) in \(phPickerViewController)")
                }))
            }
            
            if pickedImages != nil {
                ScrollView {
                    ForEach(pickedImages!, id:\.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 66, height: 66)
                            .cornerRadius(33)
                    }
                }
            }
            
            Spacer()
        }
    }
}
```

## 🪁 Demo project

For a comprehensive Demo project check out: 
<a href="https://github.com/rebeloper/ImagePickerViewDemo">ImagePickerViewDemo</a>

## ✍️ Contact

<a href="https://rebeloper.com/">rebeloper.com</a> / 
<a href="https://www.youtube.com/rebeloper/">YouTube</a> / 
<a href="https://store.rebeloper.com/">Shop</a> / 
<a href="https://rebeloper.com/mentoring">Mentoring</a>

## 📃 License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
