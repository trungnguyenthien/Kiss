# KissUI-iOS



### Requirements

- iOS 10.0+

* Xcode 11.4.0+ 

- Swift 5.0+

### Installation

##### Carthage

To integrate Kiss into your Xcode project using Carthage, specify it in your `Cartfile`:

```shell
github "trungnguyenthien/kiss"
```

Then, run `carthage update` to build the framework and drag the built `Kiss.framework`, `yoga.framework`, `YOgaKit.framework` into your Xcode project.

![image1](https://tva1.sinaimg.cn/large/007S8ZIlgy1ggr8if2eu5j30vi08ymy2.jpg)

##### Sign-in Embed framework

Please make sure your added below Run Script for sign external framework

![Screen Shot 2020-07-15 at 05.04.10](https://tva1.sinaimg.cn/large/007S8ZIlgy1ggr8llr1h5j31eq0d0di3.jpg)

```shell
for f in $(find $CODESIGNING_FOLDER_PATH -name '*.framework')
do
    codesign --force --sign "${CODE_SIGN_IDENTITY}" --preserve-metadata=identifier,entitlements --timestamp=none "$f"
done
```

