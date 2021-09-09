`###` for sub-titles

# Subscripts
> * shortcuts for accessing the member elements of a collection, list, or sequence
> * set and retrieve values w/o separating methods for setting and retrieval

### Subscript Syntax `subscript`
* specify one or more input parameters and a return type
* subscripts can be read-write or read-only
```swift
subscript(index: Int) -> Int {
    get {
        // Return an appropriate subscript value here.
    }
    set(newValue) {
        // Perform a suitable setting action here.
    }
}
```
* `newValue` is the same as the return value of the subscript
* a default parameter called `newValue` is provided to the setter if any parameter is not provided
* with read-only computed properties, a read-only subscript can be definedby removing `get` 
```swift
subscript(index: Int) -> Int {
    // Return an appropriate subscript value here.
}
```
```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"
```
