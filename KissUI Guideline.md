# KissUI Guideline

```swift
func regularLayout(baseWidth: Double) {
  return hstack(baseWidth).height(.min(400)).padding(5).align(.left).items(
  		vstack(80).autoHidden(.never).items(image.size(80)),
    	vstack(.fill(1)).leading(5).items(
      		titleLabel, 
        	subTitleLabel.top(5),
        	hstack().top(10).autoHidden(.ifEmpty).items(
              mainPriceLabel, 
              originPriceLabel.leading(5)
          ),
        	rateStarView,
        	storeLocationLabel,
        	vspring(),
        	button
      )
  )
}
```



Thuộc tính witdh có các tham số

* {double}: size cứng

* .fill(double): fill theo chiều rộng còn lại sau khi đã trừ những phần size cứng và leading, trailing.

