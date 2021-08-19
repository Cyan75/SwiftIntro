# Enumerations
> Swift Enumerations are first-class types

## 1. Enumeration Syntax
* values defined in an enumeration is called enumeration cases
```swift
enum CompassPoint {
    case north
    case south
    case east
    case west
}
```
* multiple cases can appear on a single line
```swift
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```
* Starts with a capital, plural names
* type inference
```swift
var directionToHead = CompassPoint.west
directionToHead = .east
```

## 2.Matching Enumeration Values with a Switch Statement
* with a switch statement
```swift
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
```
* with a default
```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"
```

## 2. Iterating over Enumeration Cases `allCases`
* with switch sentence
```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"
```
* with for-in loop
```swift
for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice
```

## 3.Associated Values
* Swift enumerations can store associated values of any given type
* the value types can be different for each case of the enumeration if needed
* like *discriminated unions*, *tagged unions*, or *variants*
* two types of barcodes
  * UPC(1D) : contains digital numbers from 0 to 9
  * QR(2D) : contains ISO 8859-1 character, encodes a string up to 2,953 chars long
```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```
```swift
var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
```
* with switch statement
```swift
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```
* in case all the extracted values are variables or all the extracted values are constants : single `var` or `let` would do
```swift
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

## 4.Raw Values
* the same types of cases can be populated : each raw value must be unique
```swift
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
``` 
  * the raw value for a particular enumeration case is always the same
  * associated can be different each tume it is created as a new constant or variable
* Implicitly Assigned Raw Values
    * For enumeration storing integer or string raw values, swift may assign it automatically 
    ```swift
    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
    ```
  * Planet.mercury has an explicit raw value of 1, Planet.venus has an implicit raw value of 2, and so on
  ```swift
  enum CompassPoint: String {
    case north, south, east, west
  }
  ```
  * use `rawValue` property
  ```swift
  enum CompassPoint: String {
    case north, south, east, west
  }
  ``` 
* Initialising from a Raw Value
  * defining an enumeration with a raw-value type ...
    * calls an initializer that takes a value of the raw value’s type
    * returns either an enumeration case or `nil`
    * this initialiser can be used to create a new instance of the enumeration
    ```swift
    let possiblePlanet = Planet(rawValue: 7)
    // possiblePlanet is of type Planet? and equals Planet.uranus
    ```
    * the raw value initialiser is a failable initialiser because not every raw value will return an enumeration case
    ```swift
    let positionToFind = 11
    if let somePlanet = Planet(rawValue: positionToFind) {
        switch somePlanet {
        case .earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
    } else {
        print("There isn't a planet at position \(positionToFind)")
    }
    // Prints "There isn't a planet at position 11"
    ```
    * finding a planet with a position 11, the optional `Planet` will return `nil` for the raw value initialiser
## 5.Recursive Enumerations