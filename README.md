

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

* Hello World
* Stack layout (`vstack()`, ` hstack()`,  `wrap()`)
* Mix Layout
* Show/Hide item in layout
* Main Alignment - Cross Alignment 
* Overlay Layer (`overlay()`)
* Size, Margin, Padding 
* Spacer Items (spacer, growSpacer, stretchSpacer)
* Tip: Custom View with Kiss Layout
* Tip: Multiple Layout
* Tip: Share Layout to other layout containers

#### 💋 Hello World

```swift

class HelloWorldView: UIView {
    lazy var mainLayout = wrap {
        // This is UILabel, you can add any UIView to kiss layout
        label("HELLO ", .red).kiss.layout
        label("WORLD ", .orange).kiss.layout
    }.padding(10).mainAlign(.center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set current layout is mainLayout
        // If you need switch to other layout, let use this method again.
        kiss.constructIfNeed(layout: mainLayout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        kiss.constructIfNeed(layout: mainLayout)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        // Update layout for new size
        kiss.updateChange(width: frame.width, height: frame.height)
    }
}
```



![image-20200813200701392](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghphmd5f9fj30m80cjta0.jpg)



#### 💋 Stack layout (`vstack()`, ` hstack()`,  `wrap()`)

Kiss hiện đang cung cấp 3 Group Layout căn bản để bố cục vị trí view trên layout:

##### ⭐️ Hstack: Horizontal Stack Layout

```swift
/**
Đây là những method support tạo ra UIView, UILabel bình thường.
Tôi recommend nên tách code tạo, design control với code layout vị trí, frame control 
(không nên trộn chung với nhau như SwiftUI)
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

![image-20200810064742842](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpht25rv9j30go09d3ys.jpg)

Lưu ý: Các item trong hstack phải có thể xác định được WidthValue, bằng 1 trong các cách sau để xác định WidthValue:

* Nếu item là UILabel hoặc UIView có content (vd: UISwitch) thì sẽ có width mặc định fit với content của item.
* Hard WidthValue bằng `.width(value)`
* Xác định WidthValue nếu đã cố định được HeightValue bằng `.ratio(wValue/hValue)`. Ví dụ ở trên, `.ratio(1/2)` là `width/height = 1/2`
* Nếu HStack đã xác định được WidthValue, có thể xác định WidthValue của item bằng `.grow(value)`

##### ⭐️ Vstack: Vertical Stack Layout

```swift
vstack {
	blueView.kiss.layout.height(40).margin(5)
	uiswitch.kiss.layout
	text1.kiss.layout.margin(5)
	redView.kiss.layout.grow(1).margin(5)
	greenView.kiss.layout.grow(0.5).ratio(2/1).margin(5)
}.padding(10)
```

![image-20200811221104689](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpht6qnmwj30go09daaf.jpg)

Lưu ý: Tương tự hstack, vstack cũng yêu cầu item phải xác định được HeightValue:

* Nếu item là UILabel hoặc UIView có content (vd: UISwitch) thì sẽ có height mặc định fit với content của item.
* Hard HeightValue bằng `.height(value)`
* Xác định HeightValue nếu đã cố định được WidthValue bằng `.ratio(wValue/hValue)`. 
* Nếu VStack đã xác định được HeightValue, có thể xác định HeightValue của item bằng `.grow(value)`

##### ⭐️ Wrap: Horizontal Wrap Layout

```swift
func box(
    _ width: Double,
    _ height: Double,
    _ color: UIColor = MaterialColor.blue600
) -> Kiss.UIViewLayout {
    return view(color).cornerRadius(4).kiss.layout.margin(5).size(width, height)
}

wrap {
	box(50, 50)
	box(150, 20, .green).crossAlign(self: .start) // Green box's aligned at top of line
	box(50, 80)
	box(100, 50)
	box(50, 10, .orange).crossAlign(self: .end) // Orange box's aligned at bottom of line
	box(150, 50)
	box(150, 20, .red).crossAlign(self: .center) // Red box's aligned at center of line
	box(50, 80)
	box(100, 50)
	box(50, 50)
}.padding(10).mainAlign(.center) // All boxes are aligned center
```



![image-20200813192614046](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpggh0pagj30yk0gswfc.jpg)

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

