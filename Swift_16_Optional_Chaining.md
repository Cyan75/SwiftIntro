# Optional Chaining
> * optional chaining : querying and calling properties, methods, and subscripts on an optional that might currently be nil

## 1. Optional Chaining as Alternative to Forced Unwrapping
* forced unwrapping triggers a runtime error when the optional is nil
* optional chaining fails when the optional is nil
  * the result of an optional chaining call is always an optional value
  * the result of an optional chaining call is of the same type as the expected return value, but wrapped in an optional 
    * `Int` ⟶ `Int?`
  ```swift
  class Person {
    var residence: Residence?
  }

  class Residence {
    var numberOfRooms = 1
  }
  ```
  * `residence` property is default initialized to nil when a new `Person` instance is created
  ```swift
  let john = Person()
  ```
  * because there’s no `residence` value to unwrap, accessing `numberOfRooms` with an exclamation point (force unwrapping) will trigger a runtime error
  ```swift
  let roomCount = john.residence!.numberOfRooms
  // this triggers a runtime error
  ```
  * To use optional chaining, use a question mark in place of the exclamation point
  ```swift
  if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
  } else {
     print("Unable to retrieve the number of rooms.")
  }
  // Prints "Unable to retrieve the number of rooms."
  ```
  * empt to access `numberOfRooms` has the potential to fail, the optional chaining attempt returns a value of type `Int?`, or optional `Int`
  * The optional Int is accessed through optional binding to unwrap the integer and assign the non-optional value to the `roomCount` constant
  * this is true even though `numberOfRooms` is a non-optional Int
  ```swift
  john.residence = Residence()
  ```
  * `john.residence` no longer has a nil value
  ```swift
  if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
  } else {
     print("Unable to retrieve the number of rooms.")
  }
  // Prints "John's residence has 1 room(s)."
  ```
## 2. Defining Model Classes for Optional Chaining
* multilevel optional chaining
```swift
class Person {
    var residence: Residence?
}
```
```swift
class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
```
* The computed `numberOfRooms` property simply returns the value of the count property from the `rooms` array
  * `numberOfRooms` property is implemented as a computed property, not a stored property
    * this version of `Residence` stores an array of `Room` instances
* `Residence` 
  * provides a read-write subscript that provides access to the room at the requested index in the `rooms` array 
  * provides a method called `printNumberOfRooms`, which simply prints the number of rooms in the residence
  * defines an optional property called `address`, with a type of `Address?`
```swift
class Room {
    let name: String
    init(name: String) { self.name = name }
}
```
* `Address`
  * the final class in this model
  * has three `Strings?` : `buildingName`, `buildingNumber`, and `street`
  * provides  a method called `buildingIdentifier()`, which has a return type of `String?`
```swift
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}
``` 
## 3. Accessing Properties Through Optional Chaining