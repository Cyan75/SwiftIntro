# Methods
> * methods are functions that are associated with a particular type
> * Classes, structures, and enumerations can define methods

## 1. Instance Methods
* Instance Methods
  * functions belong to instances of a particular class, structure, or enumeration
  * support functionality of those instance by providing ...
    * ways to access and modify instance properties
    * functionality related to the instance's prupose
  * exactly the same syntax as functions
  * are written within the opening and closing braces of the type it belongs to
  * it has implicit access to all other instance methods and properties of that type
  * can be called only on a specific instance of the type it belongs to
  * it cannot be called in isolation without an existing instance
  ```swift
  class Counter {
      var count = 0
      func increment() {
          count += 1
      }
      func increment(by amount: Int) {
          count += amount
      }
      func reset() {
          count = 0
      }
  }
  ``` 
  ```swift
  let counter = Counter()
  // the initial counter value is 0
  counter.increment()
  // the counter's value is now 1
  counter.increment(by: 5)
  // the counter's value is now 6
  counter.reset()
  // the counter's value is now 0
  ```
* The Self Property
  * every instance of a type has an implicit property `self` : refer to the current instance within its own instance method
  ```swift
  func increment() {
    self.count += 1
  }
  ```
  * use this when a parameter name for an instance method has the same name as a property of that instance
  ```swift
  struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
  }
  let somePoint = Point(x: 4.0, y: 5.0)
  if somePoint.isToTheRightOf(x: 1.0) {
      print("This point is to the right of the line where x == 1.0")
  }
  // Prints "This point is to the right of the line where x == 1.0"
  ```
* Modifying Value Types from Within Instance Method
  * `mutating` : the properties of a value type(structure or enumeration) can be modified
  * any changes that it makes are written back to the original structure when the method ends
  ```swift
  struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
  }
  var somePoint = Point(x: 1.0, y: 1.0)
  somePoint.moveBy(x: 2.0, y: 3.0)
  print("The point is now at (\(somePoint.x), \(somePoint.y))")
  // Prints "The point is now at (3.0, 4.0)"
  ```
* Assigning to self Within Mutating Method
  * assign an entirely new instance to the implicit `self` property
  ```swift
  struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
  }
  ```
  * mutating methods for enumerations can set the implicit `self` parameter to be a different case from the same enumeration
  ```swift
  enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
  }
  var ovenLight = TriStateSwitch.low
  ovenLight.next()
  // ovenLight is now equal to .high
  ovenLight.next()
  // ovenLight is now equal to .off
  ```

## 2. Type Methods