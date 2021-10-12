# Initialisation

> * the process of preparing an instance of a class
>   * set an initial value for each stored property on that instance
>   * perform any other setup or initialisation that is required before the new instance is ready for use
> * initialisers
>   * a special method that can be called to create a new instance of a particular type
> * deinitialiser
>   * performs any clean up just before an instance of that class is deallocated

## 1. Setting Initial Values for Stored Properties
* Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created
  * stored properties cannot be left in an indeterminate state
* the value of a property is set directly without calling any property observers when
  * assigning a default value to a stored property
  * setting its initial value within an initialiser

* ### Initilaisers 
  * `init` : an initialiser like an instance method with no parameters
  ```swift
  init() {
    // perform some initialization here
  }
  ```
  ```swift
  struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
  }
  var f = Fahrenheit()
  print("The default temperature is \(f.temperature)° Fahrenheit")
  // Prints "The default temperature is 32.0° Fahrenheit"
  ```
  * `Fahrenheit` structure has one stored property `temperature` which is of type `Double`
* ### Default Property Values
  * a default property value can be specified by assigning an initial value to the property when it is defined

## 2. Customising Initialisation
* ### Initialisation Parameters
  * initialisation parameters defines the type and names of values
  ```swift
  struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
  }
  let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
  // boilingPointOfWater.temperatureInCelsius is 100.0
  let freezingPointOfWater = Celsius(fromKelvin: 273.15)
  // freezingPointOfWater.temperatureInCelsius is 0.0
  ```
  * the first initialiser
    * `fahrenheit` is a parameter name
    * `fromFahrenheit` is an argument label
  * the second initialiser
    * `kelvin` is a parameter name
    * `fromKelvin` is an argument label
  * both initialisers convert their single argument into the corresponding Celsius value and store this in `temperatureInCelsius` property

* ### Parameter Names and Argument Labels
  * initialisation parameters can have both a parameter name and an argument label
  * initialisers do not have an identifying function name before their parentheses
    * names and types of the initialiser is crucial for identifying which initialiser should be used
    * Swift provides an automatic argument label for every parameter in an initialiser if there is not provided any
  ```swift
  struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
  }
  ```
  * both initialisers can create a new `Color`
  ```swift
  let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
  let halfGray = Color(white: 0.5)
  ```
  * it is possible to call these initialisers without using argument labels
  ```swift
  let veryGreen = Color(0.0, 1.0, 0.0)
  // this reports a compile-time error - argument labels are required
  ```
* ### Initialiser Parameters Without Argument Labels `_`
* use an underscore for the parameter to override the default behaviour without an argument label
```swift
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius is 37.0
```
* ### Optional Property Types
  * a stored property allowing to have no value cannot be set during initialisation
  * Properties of optional type are automatically initialised with a calue of `nil`
    * whis indicates that the property is deliberately intended to have no value yet during initialisation
  ```swift
  class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
  }
  let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
  cheeseQuestion.ask()
  // Prints "Do you like cheese?"
  cheeseQuestion.response = "Yes, I do like cheese."
  ```
  * `response` is declared with a type of `String?` because the response to a survey question is not known 
    * it is automatically assigned a default value of `nil` when a new instance of `SurveyQuestion` is initialised
* ### Assigining Constant Properties During Initialisation
* it is possible to assign a value to a constant property at any point during initialisation
* once a constant property is assigned a value, it cannot be further modified
  * a constant property of a class instance can be modified during initialisation only by the class that introduces it
  * it cannot be modified by a subclass
```swift
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"
``` 
* `SurveyQuestion` can be revised with a constant variable to indicate that the question does not change once an instance of `SurveyQuestion` is created
* Even though `text` is now a constant, it can still be set within the class’s initializer

## 3. Default Initialisers
* default initialiser provides default values for all of its properties
  * does not provides at least one initialiser itself
  * it creates a new instance with all of its properties set to their default values
  ```swift
  class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
  }
  var item = ShoppingListItem()
  ```
  * `ShoppingListItem` is a base class with no superclass and all of which properties have default values
    * it automatically gains a default initialiser implementation creating a new instance with all of its properties set to their default values
    * `ShoppingListItem()` is the default initialiser 
* ### Memberwise Initialisers for Structure Types
* a structure receives a memberwise initialiser even if it has stored properties that do not have default values
* The memberwise initializer is a shorthand way to initialize the member properties of new structure instances
  * Initial values for the properties of the new instance can be passed to the memberwise initializer by name
```swift
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```
* The Size structure automatically receives an init(width:height:) memberwise initializer
  * a new `Size` instance can be used
```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"
```
* any properties that have default values can be omitted

## 4. Initialiser Delegation for Value Types
> * initialiser delegation : an initialiser calling other initialiser to perform part of an instance's initialisation
* initialiser delegation by different types
  * Value types(structures, enumerations)
    * delegate to another initialiser that they provide themselves
    * use `self.init` to refer to other initialiser from the same value type when writing an initialiser
    * when a custom initialiser for a value type is defined, accessing to the default initialiser will not be available
      * use extensions to make custom value types to be initialisable with the default, memberwise, and custom initialisers
  * Class
    * classes shoud ensure that all stored properties they inherit are assigned a suitable value during initialisation
  ```swift
  struct Size {
      var width = 0.0, height = 0.0
  }
  struct Point {
      var x = 0.0, y = 0.0
  }
  ```
    * initialising `Rect` in three ways : in case that the struct would have received if it did not have its own custom initialisers
      1. use its default zero-initialised `origin` and `size` property values
      2. provide a specific origin point and size
      3. provide a specific centre point and size
    ```swift
    struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
  }
  ```
  * `init() {}` is functionally the same as the default initialiser 
    * calling this returns a `Rect` instance with the default `origin` and `size` of `Point(x: 0.0, y: 0.0)` and `Size(width: 0.0, height: 0.0)` from their property definitions
    ```swift
    let basicRect = Rect()
    // basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)
    ```
  * `init(origin:size:)` is functionally the same as the memberwise initialiser
    * this initialiser simply assigns the `origin` and `size` argument values to the appropriate stored properties
    ```swift
    let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
    // originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)
    ```
  * `init(center:size)` starts by calculating an appropriate origin point based on a `center` point and a `size` 
    * it calls(or delegates) to the `init(origin:size:)` initialiser, which stores the new origin and size values in the appropriate properties
    ```swift
    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
    // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
    ```
    * it is convenient fot the `init(center:size:)` initialiser to take advantage of an existing initialiser that aleady provides exactly that functionality

## 5. Class Inheritance and Initialisation    
* ### Designated Initialisers and Convenience Initialisers
  * Designated Initialisers
    * fully initialise all properties introduced by that class 
    * calls an appropriate subclass initialiser to continue the initialisation process up the superclass chain
    * Every class must have at least one designated initialiser
    * Automatic initialiser inheritance : a subclass is inheriting one or more designated initialisers from a superclass
  * Convenience Initialisers
    * call a designated initialiser from the same class as the convenience initialiser with some of the designated initialiser's parameters set to default values
    * create an instance of that class for a specific use case or input value type
    * create whenever a shortcut to a common initialisation pattern to save time or to make initialisation of the class cleaner in intent
    * not always required 
* ### Syntax for Designated and Convenience Initialisers
  * Designated Initialisers
  ```swift
  init(parameters) {
    statements
  }
  ```
  * Convenience Initialisers
  ```swift
  convenience init(parameters) {
      statements
  }
  ```
* ### Initialiser Delegation for Class Type
  1. A designated initializer must call a designated initializer from its immediate superclass
  2. A convenience initializer must call another initializer from the same class
  3. A convenience initializer must ultimately call a designated initializer
  > * Designated initializers must always delegate up
  > * Convenience initializers must always delegate across

* ### Two-Phase Initialisation
  > * for a safe initialisation 
  > * for giving complete flexibilty to each class in a class hierarchy
  * each stored property is assigned an initial value by the class that introduced it
  *  each class is given the opportunity to customise its stored properties further before the new instance is considered ready for use
  * #### safety checks by Swift compiler
    1. A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer
    2. A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property
      * If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization
    3. A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class)
      * If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer
    4. An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete
  * #### Phase1
    * A designated or convenience initializer is called on a class
    * Memory for a new instance of that class is allocated. The memory isn’t yet initialized
    * A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized
    * The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
    * This continues up the class inheritance chain until the top of the chain is reached
    * Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete
  * #### Phase2
    * Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on
    * Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.

* ### Initialiser Inheritance and Overriding
  * Swift subclasses do not inherit their superclass initialisers by default
  * use `override` before a subclass's initialiser definition that matches a superclass defignated initialiser
    * Swift checks that the superclass has a matching designated initialiser to be overriden 
    * Swift validates that the parameters for the overriding initialiser have been specified as intended
  * when providing a matching implementation of a supercalss convenience initialiser, `override` cannot be used
    * a subclass initialiser that matches a superclass convenience initialiser can never call the superclass initialiser
  ```swift
  class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
  }
  ```
  ```swift
  class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
  }
  ``` 
  * `override init()` : a custom designated initialiser which matches a designated initialiser from the supercalss of `Bicycle`
  * `super.init()` : calls the default initialiser for `Bicycle`'s superclass
    * inherited property `numberOfWheels` is initialised by `Vehicle` before `Bicycle` has the opportunity to modify the property
  ```swift
  let bicycle = Bicycle()
  print("Bicycle: \(bicycle.description)")
  // Bicycle: 2 wheel(s)
  ``` 
  * `super.ini()` can be omitted if...
    * a subclass initialiser performs no customisation in phase 2 of the initialisation process and, 
    * the superclass has a zero-argument designated initialiser
  ```swift
  class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
  }
  ``` 
  ```swift
  let hoverboard = Hoverboard(color: "silver")
  print("Hoverboard: \(hoverboard.description)")
  // Hoverboard: 0 wheel(s) in a beautiful silver
  ```
  * Subclasses can modify inherited variable properties during initialization, but can’t modify inherited constant properties
* ### Automatic Initialiser Inheritance


