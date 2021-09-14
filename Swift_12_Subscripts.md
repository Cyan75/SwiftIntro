`###` for sub-titles

# Subscripts
> * shortcuts for accessing the member elements of a collection, list, or sequence
> * set and retrieve values w/o separating methods for setting and retrieval

### 1.Subscript Syntax `subscript`
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
## 2.Subscript Usage
* a shortcut for accessing the member elements in a collection, list, or sequence
```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
```

## 3.Subscript Options
* take any number of input parameters of any type
* can return a value of any type
* can take a varying number of parameters (function-like)
* cannot use in-out parameters
* subscript overloading : subscript implemtations can be provided for a class or a structure as it needs
* can be defined with multiple parameters
```swift
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
```
* a new `Matrix` instance can be constructed by passing an appropriate row and column count to its initialiser
```swift
var matrix = Matrix(rows: 2, columns: 2)
```
* passing row and column values into the subscript, separated by comma, sets values in the matrix
```swift
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
```
* the subscripts's setter and getter both contain an assertion to check that the subscrip's row and column values are valid
```swift
func indexIsValid(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
}
```
* an assertion is triggered if you try to access a subscripts that is outside of the matrix bounds
```swift
let someValue = matrix[2, 2]
// This triggers an assert, because [2, 2] is outside of the matrix bounds.
```
## 4.Type Subscripts `static`
* Instance Subscript : called on an instance of a particular type
* Type subscript : called on the type itself
  * Classes can ise `clasee` instead to allow subclasses to override the superclass's implementation of that subscript
```swift 
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
```