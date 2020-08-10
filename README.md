![image-20200726084248979](https://tva1.sinaimg.cn/large/007S8ZIlgy1gh44p09jjgj30ha09ujt7.jpg)

<p align="center">
  <a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" /></a> <a href="https://raw.githubusercontent.com/layoutBox/PinLayout/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/PinLayout.svg" /></a>



Kiss is based on `facebook/yoga` (ReactNative's layout engine) for layout of **UIKit**-**Control** with much more **SIMPLE** code style than Apple's LayoutContraint. 

Kiss has group layout container `vstack / hstack / wrap` similiar to **SwiftUI**.

### Requirements

- iOS 10.0+

* Xcode 11.4.0+ 

- Swift 5.1+

### Guideline

* Stack layout (`vstack()`, ` hstack()`,  `wrap()`)
* Main Alignment - Cross Alignment 
* Overlay Layer (`overlay()`)
* Size, Margin, Padding 
* Spacer Items (spacer, growSpacer, stretchSpacer)
* Tip: Custom View with Kiss Layout
* Tip: Multiple Layout
* Tip: Share Layout to other layout containers

#### 💋 Stack layout (`vstack()`, ` hstack()`,  `wrap()`)

Kiss hiện đang cung cấp 3 Group Layout căn bản để bố cục vị trí view trên layout:

##### ⭐️ Hstack: Horizontal Stack Layout

```swift
/**
Đây là những method support tạo ra UIView, UILabel bình thường.
Tôi recommend nên 
**/
let blueView = view(.blue)
let redView = view(.red)
let greenView = view(.green)
let text1 = large(text: "Horizontal Stack Layout", line: 2).background(.orange)
let text2 = large(text: "Horizontal Stack Layout", line: 2).background(.lightGray)

hstack {
	blueView.kiss.layout.ratio(1/2).margin(5)
	text1.kiss.layout.grow(2).margin(5).crossAlign(self: .start)
	text2.kiss.layout.grow(2).margin(5).crossAlign(self: .start).marginTop(20)
	redView.kiss.layout.grow(1).margin(5)
	greenView.kiss.layout.height(80).grow(1).margin(5)
}.padding(10)
```

![image-20200810064742842](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghldnuoab8j30go09dmxo.jpg)

Lưu ý: Các item trong hstack phải có thể xác định được WidthValue, bằng 1 trong các cách sau để xác định WidthValue:

* Nếu item là UILabel hoặc UIView có content (vd: UISwitch) thì sẽ có width mặc định fit với content của item.
* Hard WidthValue bằng `.width(value)`
* Xác định WidthValue nếu đã cố định được HeightValue bằng `.ratio(wValue/hValue)`. Ví dụ ở trên, `.ratio(1/2)` là `width/height = 1/2`
* Nếu Group đã xác định được WidthValue, có thể xác định WidthValue của item bằng `.grow(value)`



#### 💋 Main Alignment - Cross Alignment 



### Installation

##### ⛔️ CocoaPods (not yet 🙏 )

##### ✅ Carthage 

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

