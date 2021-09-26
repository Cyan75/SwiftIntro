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

* Initilaisers 
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
* Default Property Values
  * a default property value can be specified by assigning an initial value to the property when it is defined

## 2. Customising Initialisation
