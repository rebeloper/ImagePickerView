# 🌇 ImagePickerView

![swift v5.3](https://img.shields.io/badge/swift-v5.3-orange.svg)
![platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)
![deployment target iOS 13](https://img.shields.io/badge/deployment%20target-iOS%2013-blueviolet)
![YouTube tutorial](https://img.shields.io/badge/YouTube-video%20tutorial-red)

**ImagePickerView** is a lightweight library which adds `UIImagePickerController` to `SwiftUI`.

## 💻 Installation
### 📦 Swift Package Manager
Using <a href="https://swift.org/package-manager/" rel="nofollow">Swift Package Manager</a>, add it as a Swift Package in Xcode 11.0 or later, `select File > Swift Packages > Add Package Dependency...` and add the repository URL:
```
https://github.com/rebeloper/NavigationKit.git
```
### ✊ Manual Installation
Download and include the `ImagePickerView` folder and files in your codebase.

### 📲 Requirements
- iOS 13+
- Swift 5.3+

## 👉 Import

Import `ImagePickerView` into your `View`

```
import ImagePickerView
```

## 🧳 Features

Here's the list of the awesome features `ImagePickerView` has:
- [X] use `UIImagePickerController` as a `View` in `SwiftUI` projects
- [X] `didCancel` and `didSelect` delegate callbacks
- [X] enable/disable editing

## How to Use

Using `ImagePickerView` could not be simpler. Just check out this example where the `ImagePickerView` is presented upon a tap of a `Button`. 

```
import SwiftUI
import ImagePickerView

struct ImagePickerViewExampleView: View {
    
    @State var isImagePickerViewPresented = false
    @State var pickedImage: UIImage? = nil
    
    var body: some View {
        Button {
            isImagePickerViewPresented = true
        } label: {
            VStack {
                if pickedImage == nil {
                    Image(systemName: "camera")
                        .font(.largeTitle)
                        .foregroundColor(.purple)
                } else {
                    Image(uiImage: pickedImage!)
                        .resizable()
                        .frame(width: 66, height: 66)
                        .cornerRadius(33)
                }
            }
        }
        .fullScreenCover(isPresented: $isImagePickerViewPresented) {
            ImagePickerView(allowsEditing: true, delegate: ImagePickerView.Delegate(didCancel: {
                isImagePickerViewPresented = false
            }, didSelect: { (image) in
                isImagePickerViewPresented = false
                pickedImage = image
            }))
        }
    }
}
```

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
