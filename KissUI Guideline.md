# KissUI Guideline

```swift
func regularLayout() {
  return hstack(width: 200).minHeight(400).padding(5).align(.left).children(
  		vstack(width: 80).willGone(.never).children(image.size(80)),
    	vstack(fill: 1).leading(5).children(
      		titleLabel, 
        	subTitleLabel.top(5),
        	hstack().top(10).willGone(.ifEmpty).children(
              mainPriceLabel, 
              originPriceLabel.leading(5)
          ),
        	rateStarView,
        	storeLocationLabel
      )
  )
}
```



Thuộc tính witdh có các tham số

* {double}: size cứng

* .fill(double): fill theo chiều rộng còn lại sau khi đã trừ những phần size cứng và leading, trailing.

