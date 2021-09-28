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