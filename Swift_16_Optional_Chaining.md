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
* Optional chaining for methods that do not return a value `Void?`
```swift
func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
}
```
* the return values are always of an optional type when called through optional chaining
```swift
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// Prints "It was not possible to print the number of rooms."
```
* to see if the property was set through optional chaining successfully
```swift
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// Prints "It was not possible to set the address."
```
## 4. Accessing Subscripts Through Optional Chaining
* optional chaining and subscripts
  * question mark before the subscript's bracket
  * retrieve and set a value from a subscript on an optional value
  * check whether that subscript call is successful
```swift
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "Unable to retrieve the first room name."
```
* set a new value through a subscript with optional chaining
```swift
john.residence?[0] = Room(name: "Bathroom")
```
  * This subscript setting attempt also fails, because residence is currently nil
* creating and assigning an actual `Residence` instance to `john.residence` with `Residence` subscript and optional chaining of `rooms`
```swift
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "The first room name is Living Room."
```
### Accessing Subscripts of Optional Type
* place a question mark after the subscript's closing bracket to chain on a subscript returning a value of optional type
```swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
```
## 5. Linking Multiple Levels of Chaining
* multiple levels of optional chaining : drill down to properties, methods, and subscripts deeper within a model
* multiple levels of optional chaining do not add more levels of optionality to the returned value
  * If the type is not optional, it will become optional because of the optional chaining
    * If an `Int` is tried to be retrieved through optional chaining, an `Int?` is always returned, no matter how many levels of chaining are used
  * If the type is already optional, it will not become more optional because of the chaining
    * If an `Int?` is tried to be retreived through optional chaining, an `Int?` is always returned, no matter how many levels of chaining are used
```swift
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."
```
  * the value of `john.residence.address` is currently `nil`
    * `john.residence?.address?.street` fails
  * The type of `street` is `String?`
  * the return value of `john.residence?.address?.street` is `String?`
    * the underlying optional type of the property is `String?`
  * use multilevel optional chaining to set an actual value for `john.residence.address` and `street`
  ```swift
  let johnsAddress = Address()
  johnsAddress.buildingName = "The Larches"
  johnsAddress.street = "Laurel Street"
  john.residence?.address = johnsAddress

  if let johnsStreet = john.residence?.address?.street {
      print("John's street name is \(johnsStreet).")
  } else {
      print("Unable to retrieve the address.")
  }
  // Prints "John's street name is Laurel Street."
  ```
  * the attempt to set `adress` of `john.residence` will succeed, because the value of `john.residence` currently contains a valid `Residence` instance
## 6. Chaining on Methods with Optional Return Values
* Optional chaining can be use to call a method that returns a value of optional type and to chain on that method's return value if needed
```swift
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Prints "John's building identifier is The Larches."
```
  * calls `Address`'s `buildingIdentifier()` through optional chaining
  * `buildingIdentifier()` returns a `String?` value
* question mark after the parentheses : further optional chaining on the return value of `buildingIdentifier()`
  * the optional value is the `buildingIdentifier()`'s return value not the method itself
```swift
if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}
// Prints "John's building identifier begins with "The"."
```