# Properties
> **A property, in some object-oriented programming languages, is a special sort of class member, intermediate in functionality between a field (or data member) and a method**
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
  * the properties can be changed in case the instance is of a constant reference type 

* Lazy Stored Properties `lazy`
  * a lazy stored property is a property whose initial value is not calculated until the first time it is used
  * it must be declared to be **variable** 
  * useful when...
    * the initial value for a property is dependent on outside factors which is not known until after an instance's initialisation is complete
    * the initial value for a property requires complex or computationally expensive setup that should not be performed unless or until it is neede
  ```swift
  class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
        // the DataImporter class would provide data importing functionality here
    }
  class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
  }
  let manager = DataManager()
  manager.data.append("Some data")
  manager.data.append("Some more data")
  // the DataImporter instance for the importer property hasn't yet been created
  ```
  * data importing functionality of `DataManager` is provided by `DataImporter` which is assumed to take a nontrivial amount of time to initialise
  * the lazy property `importer` is only created when the `importer` property is first accessed 
  ```swift
  print(manager.importer.filename)
  // the DataImporter instance for the importer property has now been created
  // Prints "data.txt"
  ```
  * a `lazy`-marked property accessed by multiple threads can be initialised multiple times 

* Stored Properties and Instance Variables
  * all information about the property including its name, type, and memory management characteristics is defined in a single location as part og the type's definition


## 2.Computed Properties
* Computed properties provide a getter and an optional setter
```swift
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"
```
  * `Point` encapsulates the x- and y-coordinate of a point
  * `Size` encapsulates a width and a height
  * `Rect` 
    * defines a rectangle by an origin point and a size
    * provides a computed property called `center`
    * the current centre position of a `Rect` can be determined from its `origin` and `size`; storing another instance of `Point` for centre is unnecessary
  * a new variable `square` is initialised with (0,0) and width = 10
    * `center` of `square` is accessed through `.`

* Shorthand Setter Declaration
  * the default name for a computed property's new value is `newValue`
  ```swift
  struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
  }
  ```
* Shorthand Getter Declaration
  * if the entire body of a getter is a single expression, the getter implicity returns that expression
  ```swift
  struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
  }
  ```
* Read-Only Computed Properties
  * a computed property with a getter but no setter 
  * remove `get`
  * always returns a value
  * can be set through `.`
  ```swift
  struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
  }
  let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
  print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
  // Prints "the volume of fourByFiveByTwo is 40.0"
  ```
## 3.Property Observers
* Property observers observe and respond to changes in a property's value
  * Property observers are called every time when a property's value is set
* can be added in the following places
  * Stored properties that you define
  * Stored properties that you inherit
  * Computed properties that you inherit

* inherited or computed property 
  * a inherited property : a property in a subclass is overriden by a property observer
  * a computed property : use the property’s setter to observe and respond to value changes, instead of trying to create an observer

* `willSet` : called just before the value is stored
  * it is passed the new property value as a constant parameter
  * a name can be specified for this parameter as part of `willSet` implementation
  * if there is no parameter name and parentheses within the implementation, the parameter is made available with a default parameter of `newValue`

* `didSet` : called immediately after the new value is stored
  * it is passed a constant parameter containing the old property value
  * a name can be specified for this parameter or it uses the default `oldValue`
  * if a value is assigned to a property within its own `didSet` observer, the new value that is assigned replaces the one that was just set
  