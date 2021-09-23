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
  * You can override an inherited instance or type property
    * custom getter and setter for that property 
    * add property observers to enable the overriding property to observe when the underlying property value changes

## 4. Overriding Property Getters and Setters
* a inherited stored or computed property can have a custom getter and setter
* a subclass knows only that the inherited property has certain name and type
* both the name and the type of the overriden property must be provided
* if a setter is provided as part of a property override, there must be also a getter for that override
* use `super` in case of not modifying the inherited property's value

```swift
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
```
* `super.description` 
  * starts the override of the `description` property
  * `description` of `Vehicle` is returned
* `description` of another instance of `Vehecle` returns its own `gear` and `currentSpeed` properties
```swift
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3
```
## 5. Overriding Property Observers
* property observers to an inherited property can be overriden
  * this notifies when the value of an inherited property changes
* inherited constant stored properties or inherited read-only computed properties cannot have any property observers
  * the value of these properties cannot be set 
  * it is not appropriate to provide `willSet` or `didSet` implementation as part of an override
* providing both an overriding setter and an overriding property observer for the same property is impossible
  * to observe changes of a property's value where there a custom setter for that property is already provided, simply observe any value changes from within the custom setter

```swift
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
```
* `AutomaticCar` is a subclass of `Car`
  * it automatically selects an appropriate gear to use based on the current speed
* Whenever `currentSpeed` property of an `AutomaticCar` instance is set, the property’s `didSet` observer sets the instance’s `gear` property to an appropriate choice of `gear` for the new speed
* Specifically the property observer chooses a gear that's the new `currentSpeed` value divided by `10`, rounded down to the nearest integer, plus `1`
```swift
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4
```

## 6. Preventing Overrides `final`
* `final` modifier before the method, property or subscript's introducer keyword(such as `final var`, `final func`, `final class func`, and `final subscript`)
* any attempt to override a final method, property, or subscript in a subclass is reported as a compile-time error
* marking an entire class as final `final class` : any attempt to subclass a final class is reported as a compile-time error