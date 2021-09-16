# Inheritance
> * a class can inherit from another
>   * subclass : the inheriting class
> * call and access methods, properties and subscripts
> * add property observes to inherited properties


## 1.Defining a Base Calss
> * any class that does not inherit from another class is a base class
> * Swift classes don’t inherit from a universal base class
>   * Classes you define without specifying a superclass automatically become base classes for you to build upon
```swift
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}
```
* initialiser syntax
```swift
let someVehicle = Vehicle()
```
## 2.Subclassing `:`
* subclassing is the act of basing a new class on an existing class
```swift
class SomeSubclass: SomeSuperclass {
    // subclass definition goes here
}
```
```swift
class Bicycle: Vehicle {
    var hasBasket = false
}
```
* the new `Bicycle` class 
  * automatically gains all of the characteristics of `Vehicle`
  * defines a new stored property `hasBasket`
  * by default, any new `Bicycle` instance will not have a basket
  ```swift
  let bicycle = Bicycle()
  bicycle.hasBasket = true
  ```
* Subclass can themselves be subsclassed
```swift
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
```
* working with any of its new and inherited properties and query the read-only `description` property it inherits from `Vehicle` is possible if an instance of `Tandem` is created
```swift
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour
```

## 3.Overriding `override`
> * Overriding : a subclass provides its own custon implementation of an instance method, type method, instance property, type property or subscript
> * any overrides without `override` keyword are diagnosed as an error

* Accessing Subclass Methods, Properties, adn Subscripts
  * use `super` to access the superclass version of method, property, or subscript  

  ||subcalss|super class|
  |-|-|-|
  |method|`someMethod()`|`super.someMethod`|
  |property|`someProperty`|`super.someProperty`|
  |subscript|`someIndex`|`super[someIndex]`|

* Overriding Methods
  * an ihherited instance or type method can be overriden for providing a tailored or alternative implementation of the method within your subclass
  ```swift
  class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
  }
  ```
  * If you create a new instance of Train and call its makeNoise() method, you can see that the Train subclass version of the method is called
  ```swift
  let train = Train()
  train.makeNoise()
  // Prints "Choo Choo"
  ```
* Overriding Properties
  * You can override an inherited instance or type property to provide your own custom getter and setter for that property, or to add property observers to enable the overriding property to observe when the underlying property value changes