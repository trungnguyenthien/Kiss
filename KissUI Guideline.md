# KissUI Guideline

```swift
func render() {
  return stack(.horizontal).width(200).padding(5).align(.left).children(
  		stack(.vertical).width(80).children(image.size(80)),
    	stack(.vertical).width(.fill).leading(5).children(
      		
      )
  )
}
```



Thuộc tính witdh có các tham số

* {double}: size cứng

* .fill(double): fill theo chiều rộng còn lại sau khi đã trừ những phần size cứng và leading, trailing.

