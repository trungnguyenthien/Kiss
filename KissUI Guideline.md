# KissUI Guideline

```swift
func regularLayout() {
  return hstack(width: 200).minHeight(400).padding(5).align(.left).children(
  		vstack(width: 80).children(image.size(80)).willGone(.never),
    	vstack(fill: 1).leading(5).children(
      		titleLabel, 
        	subTitleLabel.top(5),
        	hstack().top(10).children(
          		mainPriceLabel, 
            	originPriceLabel.leading(5)
          ).willGone(.ifEmpty),
        	rateStarView,
        	storeLocationLabel
      )
  )
}
```



Thuộc tính witdh có các tham số

* {double}: size cứng

* .fill(double): fill theo chiều rộng còn lại sau khi đã trừ những phần size cứng và leading, trailing.

