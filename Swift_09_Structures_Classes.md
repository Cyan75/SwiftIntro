# Structures and Classes
> * a general-purpose building blocks
> * no separation of interface and implementation files
>   * external interfaces to classes or structures are automatically made available for other code to use
> * in general, 
>   * an object is an instance of a class
>   * in Swift, structures are often used as much as classes
>   * use more general terminology : *instance*


## 1.Comparing Structures and Classes
> most of the custom data types will be structures and enumerations
* Things in common
  * Define properties to store values
  * Define methods to provide functionality
  * Define subscripts to provide access to their values using subscript syntax
  * Define initializers to set up their initial state
  * Be extended to expand their functionality beyond a default implementation
  * Conform to protocols to provide standard functionality of a certain kind

* Exclusive additional capabilities of classes
  * Inheritance enables one class to inherit the characteristics of another.
  * Type casting enables you to check and interpret the type of a class instance at runtime.
  * Deinitializers enable an instance of a class to free up any resources it has assigned.
  * Reference counting allows more than one reference to a class instance.


* Definition Syntax
  * defining a new structure or class : defining a new Swift type
```swift
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}
```
```swift
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```
* Structure and Class Instances
  * Instantiation : initialiser syntax for new instances
  ```swift
  let someResolution = Resolution()
  let someVideoMode = VideoMode()
  ```
* Accessing Properties 
  * dot syntax `.`
    ```swift
    print("The width of someResolution is \(someResolution.width)")
    // Prints "The width of someResolution is 0"
    ```
  * drilling down
    ```swift
    rint("The width of someVideoMode is \(someVideoMode.resolution.width)")
    // Prints "The width of someVideoMode is 0"
    ``` 
  * assign a new value
  ```swift
  someVideoMode.resolution.width = 1280
  print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
  // Prints "The width of someVideoMode is now 1280"
  ```
* Memberwise Initialisers for Structure Types
  * all structure have an automatically generated memberwise initialiser
  * initial values for the properties of the new instance can be passed
  ```swift
  let vga = Resolution(width: 640, height: 480)
  ```
  * class instances do not receive a default memberwise initialiser

## 2. Structures and Enumerations Are Value Types
* a value type's value is copied when assigning or being passed to a function
* structure and enumeration type are always copied when they are passed around in your code
* Collections of the standard libraries(arrays, dictionaries, and string) are optimised to reduce the performance cost of copying
  * they share the memory where the elements are stored bwtween the original instance and any copies
  * if one copy of the collection is modified, the elements are copied just before the modification
```swift
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
``` 
  * a new copy of the existing instance is made and it is assigned to a new variable
  ```swift
  cinema.width = 2048
  ```
  * `width` of `cinema` has changed
  ```swift
  print("cinema is now \(cinema.width) pixels wide")
  // Prints "cinema is now 2048 pixels wide"
  ```
  * `width` of hd instance still remains the same
  ```swift
  print("hd is still \(hd.width) pixels wide")
  // Prints "hd is still 1920 pixels wide"
  ```
* enumeration has the same behaviour
```swift
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"
```

## 3.Classes Are Reference Types
* reference types are not copied when they are assigned or passed
```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
```
* assign `tenEignty` to a new constant
```swift
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```
* `tenEighty` and `alsoTenEighty` refer to the same instance
  * two different name for the single instance
```swift
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"
```
* Even though `tenEighty` and `alsoTenEighty` are constants, `tenEighty.frameRate` and `alsoTenEighty.frameRate` can be changed because they refer the `VideoMode` instance
  * 'a const pointer'

* Identity Operators