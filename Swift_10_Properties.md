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

* `willSet` and `didSet`
  * `willSet` : **called just before the value is stored**
    * it is passed the new property value as a constant parameter
    * a name can be specified for this parameter as part of `willSet` implementation
    * if there is no parameter name and parentheses within the implementation, the parameter is made available with a default parameter of `newValue`

  * `didSet` : **called immediately after the new value is stored**
    * it is passed a constant parameter containing the old property value
    * a name can be specified for this parameter or it uses the default `oldValue`
    * if a value is assigned to a property within its own `didSet` observer, the new value that is assigned replaces the one that was just set
  
  * When a property is set in a subclass... 
    * the superclass initialiser is called, 
    * then, `willSet` and `didSet` observers of the superclass are called
  * `willSet` and `didSet` are not called while a class is setting its own properties, before the superclass initialiser has been called

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```

* passing a property that has observers to a function as an in-out parameter always calls the `willSet` and `didSet` observers
  * ∵ in-out parameters are of copy-in copy-out memory model
    * the value is always written back to the property at the end of the function

## 4.Property Wrappers
> * a property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property

  * define a `wrapperValue` property in a structure, enumeration or class
  ```swift
  @propertyWrapper
  struct TwelveOrLess {
      private var number = 0
      var wrappedValue: Int {
          get { return number }
          set { number = min(newValue, 12) }
      }
  }
  ```
    * `number` is used only in the implementation of `TwelveOrLess` because it is a private variable 

  * You apply a wrapper to a property by writing the wrapper’s name before the property as an attribute
  ```swift
  struct SmallRectangle {
      @TwelveOrLess var height: Int
      @TwelveOrLess var width: Int
  }

  var rectangle = SmallRectangle()
  print(rectangle.height)
  // Prints "0"

  rectangle.height = 10
  print(rectangle.height)
  // Prints "10"

  rectangle.height = 24
  print(rectangle.height)
  // Prints "12"
  ```

  * when a wrapper is applied to a property the complier synthesises 
    * code that provides storage for the wrapper
    * code that provides access to the property through a wrapper
  * code that uses a property wrapper does not need to take advantage of the special attribute syntax
  ```swift
  struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
  }
  ```

* Setting Initial Values for Wrapped Properties
  * to support setting an initial value or other customisation the property wrapper needs to add an initialiser
  ```swift
  @propertyWrapper
  struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
  }
  ```
  * the three initialisers use to set the wrapped value and the maximum value
  ```swift
  struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
  }

  var zeroRectangle = ZeroRectangle()
  print(zeroRectangle.height, zeroRectangle.width)
  // Prints "0 0"
  ```
  * the code inside the initialiser sets the initial wrapped value and the initial maximum value, using the default values of zero and 12
  * the property wrapper still provides all of the initial values
  * when you specify an intial value for the property, Swift uses initialiser that accepts those arguments to set up the wrapper
  ```swift
  struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
  }

  var narrowRectangle = NarrowRectangle()
  print(narrowRectangle.height, narrowRectangle.width)
  // Prints "2 3"

  narrowRectangle.height = 100
  narrowRectangle.width = 100
  print(narrowRectangle.height, narrowRectangle.width)
  // Prints "5 4"
  ```
  * the instance of `SmallNumber` that wraps `height` is created by calling `SmallNumber(wrappedValue: 2, maximum: 5)` and the instance that wraps `width` is created by calling `SmallNumber(wrappedValue: 3, maximum: 4)`
  * by including arguments to the property wrapper, setting up the initial state in the wrapper or passing other options to the wrapper are possible when it is created
  * this syntax is the most general way to use a property wrapper
  * you can provide whatever arguments you need to the attribute and they are passed to the initialiser
  * when you include property wrapper argumernts, you can also specify an initial value using assignment 
  * Swift treats the assignment like a `wrappedValue` argument and uses the initialiser that accepts the arguments you include
  ```swift
  struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
  }

  var mixedRectangle = MixedRectangle()
  print(mixedRectangle.height)
  // Prints "1"

  mixedRectangle.height = 20
  print(mixedRectangle.height)
  // Prints "12"
  ```
* Projecting a Value From a Property Wrapper
  * In addition to the wrapped value, a property wrapper can expose additional functionality by defining a projected value
  * the name of the projected value is the same as the wrapped value
  ```swift
  @propertyWrapper
  struct SmallNumber {
      private var number = 0
      var projectedValue = false
      var wrappedValue: Int {
          get { return number }
          set {
              if newValue > 12 {
                  number = 12
                  projectedValue = true
              } else {
                  number = newValue
                  projectedValue = false
              }
          }
      }
  }
  struct SomeStructure {
      @SmallNumber var someNumber: Int
  }
  var someStructure = SomeStructure()

  someStructure.someNumber = 4
  print(someStructure.$someNumber)
  // Prints "false"

  someStructure.someNumber = 55
  print(someStructure.$someNumber)
  // Prints "true"
  ```
  * a property wrapper can return a value of any type as its projected value
  * a wrapper that needs to expose more information can return an instance of some other data type, it can return `self` to expose the instance of the wrapper as its projected value
  * `self.` can be omitted when accessing a projected value from code that is part of type
    * like a property getter or an instance method
  ```swift
  enum Size {
    case small, large
  }

  struct SizedRectangle {
      @SmallNumber var height: Int
      @SmallNumber var width: Int

      mutating func resize(to size: Size) -> Bool {
          switch size {
          case .small:
              height = 10
              width = 20
          case .large:
              height = 100
              width = 100
          }
          return $height || $width
      }
  }
  ```
  * property wrapper syntx is just syntactic sugar for a property with a getter and a setter


## 5.Global and Local Variables
> * Global variables are variables that are defined outside of any function, method, closure or type context
> * Local variables are variables that are defined within a function, method, or closure context
  * Stored variables provide storage for a value of a certain type and allow that value to be set and retrieved
  * Computed variables calculate their value, rather than storing it, and they are written in the same way as computed properties
  * global constants and variables are always computed lazily
    * Yet, they do not need to bbe marked with `lazy`
  * local constants and variables are never computed lazily
  * applying a property wrapper to a local stored variable but not to a global variable or computed variable
  ```swift
  func someFunction() {
    @SmallNumber var myNumber: Int = 0

    myNumber = 10
    // now myNumber is 10

    myNumber = 24
    // now myNumber is 12
  }
  ```

## 6.Type Properties
* Instance Properties vs Type Properties
  * Instance Properties : properties that belong to an instance of a particular type
    * Whenever a new instance is created, it has its own set of property values, separate from any other instance
  * Type Properties : properties that bbelong to the type itself
    * there will only ever be one copy of these properties
    * useful for defining values that are universal to all instances of a particular type
      * C's `static constant` : a constant property that all instances can use
      * C's `static` : a variable property that stores a value that is global to all instances of that type 
    * stored type properties must always have default value, unlike stored instance properties
      * the type istelf does not have an initialiser that can assign a value to a stored property at initialisation time
      * stored type properties are lazily initialised on their first access
      * they are guaranteed to be initialised only once, even when accessed by multiple threads simultaneously. 
      * they do not need to be marked with `lazy`
* Type Property syntax `static`
  * Swift type properties are written as part of the type's definition, within the type's outer curly braces
  * each type property is explicitly scoped to the type it supports
  * for computed type properties for class type, `class` can be used to allow subclasses to override the superclass's implementation
  ```swift
  struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
  }
  enum SomeEnumeration {
      static var storedTypeProperty = "Some value."
      static var computedTypeProperty: Int {
          return 6
      }
  }
  class SomeClass {
      static var storedTypeProperty = "Some value."
      static var computedTypeProperty: Int {
          return 27
      }
      class var overrideableComputedTypeProperty: Int {
          return 107
      }
  }
  ```
  * the 










