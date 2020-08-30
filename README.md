

![image-20200813204548358](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpiqrtzoyj306y03umxt.jpg)

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
* Combine Layout
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

![image-20200813211927192](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpjps7agyj30go09eq3n.jpg)



Một số object và method thường dùng:

##### ⭐️ `hostView`.kiss.vstack(), `hostView`.kiss.hstack(), `hostView`.kiss.wrap()

Return Group Layout cho `hostView`. Những layout item khi được declare trong các group layout sẽ được addSubview vào trong `hostView`.

Lưu ý: Kiss Library cung cấp các global function `vstack(), hstack(), wrap()` cũng có chức năng tạo layout tương tự `kiss.vstack(), kiss.hstack(), kiss.wrap()`  , Khác nhau là các Global-Function sẽ tạo các UIView mới và bố cục layout item trong UIView mới đó, còn Kiss-Function sẽ bố cục ngay cho `hostView` đó.

```swift
class SampleView: UIView {
    lazy var ownerLayout = kiss.hstack {
        // this control is inserted in self
        UILabel().kiss.layout
    }

    let nonOwnerLayout = hstack {
        // this control is inserted in new UIView
        UILabel().kiss.layout
    }
}
```

##### ⭐️ `hostView`.kiss.constructIfNeed()

Sử dụng method này để lựa chọn Layout cần apply. Khi Group Layout được apply, các item bên trong sẽ được move sang `hostView`.

Method sẽ skip nếu 2 lần liên tiếp chọn cùng 1 layout.

##### ⭐️ `hostView`.kiss.updateChange(width: CGFloat? = **nil**, height: CGFloat? = **nil**)

Bố cục lại item ứng với kích thước `hostView` được chỉ định trong parameter (ứng với layout đang được construct)

* (width: 400, height: 200): arrange item lại để phù hợp với kích thước (400, 200) của `hostView`
* (width: 400): arrange item lại để phù hợp với chiều dài 400, chiều cao fit với content layout.
* (height: 200): arrange item lại để phù hợp với chiều cao 200, chiều dài fit với content layout.
* Nil-width, Nil-height: arrange item lại để chiều dài, chiều cao fit với content layout.

> Method này thường được sử dụng trong `layoutSubviews` hoặc khi muốn bố cục lại item sau khi set data, set hidden cho các item (vd: trong `UICollectionViewCell`)

##### ⭐️ `hostView`.kiss.estimatedSize(width: CGFloat? = **nil**, height: CGFloat? = **nil**) -> CGSize

Xác định size layout ứng với kích thước `hostView` được chỉ định trong parameter (ứng với layout đang được construct).

Tham số (width, height) trong `estimatedSize` tương tự như trong `updateChange`.

Method `estimatedSize` hoạt động độc lập với `updateChange` và hoàn toàn không ảnh hưởng đến bố cục hiện tại của item. Việc tính toán hoàn toàn dựa trên thuật toán của `yoga` .

> Method này thường được sử dụng trong tính toán `sizeForItem` hoặc heightForRow trong `UICollectionView`/`UITableView`. Hoặc khi muốn override lại các method: `sizeThatFits` hoặc `intrinsicContentSize`.

#### 💋 Combine Layout together

We can wrap group layout (`vstack`, `hstack`, `wrap`) into others, then consider them as layout item (`UIViewLayout`)

```swift
vstack {
        label("Let try new layout solution", MaterialColor.red700)
            .kiss.layout.margin(10)
        
        view(MaterialColor.green600)
            .cornerRadius(5).stroke(size: 1, color: .brown)
            .kiss.layout.crossAlign(self: .stretch).height(100).margin(10)
        
        hstack {
            box(50, 50)
            box(50, 50)
            box(50, 50)
            box(50, 50)
            box(50, 50)
        }.mainAlign(.center)
        
        view(MaterialColor.pink500)
            .cornerRadius(5).stroke(size: 1, color: .brown)
            .kiss.layout.crossAlign(self: .stretch).height(50).margin(10)
}.padding(10)
```

![image-20200813211717324](https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpjntazhfj30go09lmxs.jpg)

##### ⭐️ `cloned` layout

Chúng tôi recommend bạn không nên dùng trực tiếp 1 layout con cho nhiều layout cha.

```swift
class SampleView: UIView {
    lazy var subLayout = vstack {
        UIView().kiss.layout
    }
    
    lazy var parentLayout1 = vstack {
        UIView().kiss.layout
        subLayout.margin(10)
    }
    
    lazy var parentLayout2 = wrap {
        UILabel().kiss.layout
        subLayout.margin(15)
    }
}
```

Do `subLayout` lúc này cùng refer đến 1 instance nên những setting bên trong từng parent layout có thể sẽ không giữ được như mong muốn. Các bạn nên cloned ra thành các instance để quản lý các layout attribute (margin, padding, alignment,...) không bị ảnh hưởng lẫn nhau.

```swift
    lazy var parentLayout1 = vstack {
        UIView().kiss.layout
        subLayout.cloned.margin(10)
    }
    
    lazy var parentLayout2 = wrap {
        UILabel().kiss.layout
        subLayout.cloned.margin(15)
    }
```



#### 💋 Show/Hide item in layout

Khi set thuộc tính `isHidden` của item (là một UIView) đồng nghĩa bạn đã remove item này khỏi hệ thống layout của kiss.

```swift
    lazy var mainLayout = vstack {
        view1.kiss.layout // isHidden == false
        view2.kiss.layout // isHidden == false
        view3.kiss.layout // isHidden == false
        view4.kiss.layout // isHidden == false
        view5.kiss.layout // isHidden == false
    }
```

Khi `isHidden == true` , và layout được cập nhật lại bằng method `updateChange()`, layout sẽ được render lại và remove các invisible view ra khỏi parentView.

```swift
    lazy var mainLayout = vstack {
        view1.kiss.layout // isHidden == false
        view2.kiss.layout // isHidden == false
        view3.kiss.layout // isHidden == false
        // view4.kiss.layout // isHidden == true, or isVisible == false
        view5.kiss.layout // isHidden == false
    }
```

> Chỉ là quan điểm cá nhân thôi nhé. Tôi không thích sử dụng thuộc tính `isHidden` mà Apple cung cấp (tôi thường bị mistake khi xài thuộc tính này), nên đã bổ sung thêm thuộc tính `isVisible` ngược lại với `isHidden` để luồng suy nghĩ không bị đảo chiều. **"No Visbile, No Display"**

#### `autoInvisible` attribute

Đối với GroupLayout, bạn cũng có thể bật thuộc tính isHidden để ẩn/hiện trên layout, ngoài ra, tôi có cung cấp thêm thuộc tính `.autoInvisible(.allInvisible)` sẽ tự Invisible nếu tất cả item trong layout đã bị invisible. Mặc định các GroupLayout sẽ được  set là `.autoInvisible(.never)`.

##### ⭐️ Case: `.autoInvisible(.never)`

```swift
        view(.green).kiss.hstack {
            box1.kiss.layout.size(50, 20).margin(5) // isHidden == true
            box2.kiss.layout.size(50, 50).margin(5) // isHidden == true
        }.mainAlign(.center).autoInvisible(.never).padding(20)
```

<img src="https://tva1.sinaimg.cn/large/007S8ZIlgy1ghsu9zdfhnj30h809wmxi.jpg" alt="image-20200816173749613" style="zoom:50%;" />

Vì layout của GreenView có `padding` là 20, nên dù các item bên trong đã invisible nên vẫn có chiều cao là 40.

##### ⭐️ Case: `.autoInvisible(.allInvisible)`

```swift
        view(.green).kiss.hstack {
            box1.kiss.layout.size(50, 20).margin(5) // isHidden == true
            box2.kiss.layout.size(50, 50).margin(5) // isHidden == true
        }.mainAlign(.center).autoInvisible(.allInvisible).padding(20)
```

<img src="https://tva1.sinaimg.cn/large/007S8ZIlgy1ghsu9ylvnmj30h809w3yu.jpg" alt="image-20200816174011630" style="zoom:50%;" />

Khi GroupLayout được set `.autoInvisible(.allInvisible)`, khi các item bên trong invisible, thì Group này sẽ không được add và ParentLayout.

#### 💋 Main Alignment - Cross Alignment 

Kiss sử dụng khái niệm 2 trục của flexbox để align item trong layout. Tùy vào layout đang sử dụng mà giá trị alignment có cách bố cục khác nhau:

* Main Axis: Trục sắp xếp các item trong layout.
  * Vstack: xếp item từ top đến bottom =>  `start` aignment means align from **top**, `end` alignment means align from **bottom**.
  * HStack, Wrap: xếp item từ left đến right => `start` alignment means align from **left**, `end` alignment means align from **right**.

* Cross Axis: Trục vuông với Main Axis. 



![image-20200829172334549](https://tva1.sinaimg.cn/large/007S8ZIlgy1gi7utktt1dj31hg0kc0us.jpg)

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

<img src="https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpht25rv9j30go09d3ys.jpg" alt="image-20200810064742842" style="zoom:50%;" />

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

<img src="https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpht6qnmwj30go09daaf.jpg" alt="image-20200811221104689" style="zoom:50%;" />

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



<img src="https://tva1.sinaimg.cn/large/007S8ZIlgy1ghpggh0pagj30yk0gswfc.jpg" alt="image-20200813192614046" style="zoom: 50%;" />

#### 💋 Main Alignment - Cross Alignment 



### Installation

##### ⛔️ CocoaPods (not yet 🙏 )

##### ✅ Carthage 

To integrate Kiss into your Xcode project using Carthage, specify it in your `Cartfile`:

```shell
github "trungnguyenthien/kiss"
```

Then, run `carthage update` to build the framework and drag the built `Kiss.framework`  and nested frameworked   `yoga.framework`, `YOgaKit.framework` into your Xcode project.

<img src="https://tva1.sinaimg.cn/large/007S8ZIlgy1ggr8rxmjj4j30m20693yx.jpg" alt="007S8ZIlgy1ggr8if2eu5j30vi08ymy2" style="zoom:67%;" />

##### Sign-in Embed framework

Please make sure your added below Run Script for sign external framework

![Screen Shot 2020-07-15 at 05.04.10](https://tva1.sinaimg.cn/large/007S8ZIlgy1ggr8llr1h5j31eq0d0di3.jpg)

```shell
for f in $(find $CODESIGNING_FOLDER_PATH -name '*.framework')
do
    codesign --force --sign "${CODE_SIGN_IDENTITY}" --preserve-metadata=identifier,entitlements --timestamp=none "$f"
done
```

