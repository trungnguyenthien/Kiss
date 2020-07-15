![image-20200715221210235](https://tva1.sinaimg.cn/large/007S8ZIlgy1ggs29r7j1wj30ca066q4f.jpg)

<p align="center">
  <a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" /></a> <a href="https://raw.githubusercontent.com/layoutBox/PinLayout/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/PinLayout.svg" /></a>



Kiss is based on `facebook/yoga` (ReactNative's layout engine) for layout of **UIKit**-**Control** with much more **SIMPLE** code style than Apple's LayoutContraint. 

Kiss has group layout container `vstack / hstack / wrap` similiar to **SwiftUI**.

### Requirements

- iOS 10.0+

* Xcode 11.4.0+ 

- Swift 5.1+

### Installation

##### CocoaPods (not yet 🙏 )

##### Carthage 

To integrate Kiss into your Xcode project using Carthage, specify it in your `Cartfile`:

```shell
github "trungnguyenthien/kiss"
```

Then, run `carthage update` to build the framework and drag the built `Kiss.framework`  and nested frameworked   `yoga.framework`, `YOgaKit.framework` into your Xcode project.

![007S8ZIlgy1ggr8if2eu5j30vi08ymy2](https://tva1.sinaimg.cn/large/007S8ZIlgy1ggr8rxmjj4j30m20693yx.jpg)

##### Sign-in Embed framework

Please make sure your added below Run Script for sign external framework

![Screen Shot 2020-07-15 at 05.04.10](https://tva1.sinaimg.cn/large/007S8ZIlgy1ggr8llr1h5j31eq0d0di3.jpg)

```shell
for f in $(find $CODESIGNING_FOLDER_PATH -name '*.framework')
do
    codesign --force --sign "${CODE_SIGN_IDENTITY}" --preserve-metadata=identifier,entitlements --timestamp=none "$f"
done
```

