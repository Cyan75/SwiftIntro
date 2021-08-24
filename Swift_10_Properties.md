# Properties
> Properties associate values with a particular class, structure, or enumeration
> Stored properties store constant and variable values as part of an instance


## 1. Stored Properties
* a stored property is a constant or variable that’s stored as part of an instance of a particular class or structure
  * variable stored properties or constant stored properties
* setting a default value, setting and modifying the initial value are available
```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```
  * `firstValue` is a variable stored property
  * `length` is a constant stored property 

* Stored Propertiies of Constant Structure Instances 
  * the properties of an instance which is assigned to a constant cannot be modified
  ```swift
  let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
  // this range represents integer values 0, 1, 2, and 3
  rangeOfFourItems.firstValue = 6
  // this will report an error, even though firstValue is a variable property
  ```
  * this is because structures are value types
    * all the properties of a constant instance of a value type are constant
