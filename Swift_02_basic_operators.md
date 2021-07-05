# Basic Operators
* ternary operator : `a ? b : c`
* Arithmatic operators in Swift are safe from overflow by default
* `+` : addition operator and string concatenator
* Assignment operator `=` is available for a tuple
 ```swift
 let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
 ```
 * comparison operator is can be used with tuples
```swift
(1, "zebra") < (2, "apple")   
 // true because 1 is less than 2; "zebra" and "apple" aren't compared

(3, "apple") < (3, "bird")    
// true because 3 is equal to 3, and "apple" is less than "bird"

(4, "dog") == (4, "dog")      
// true because 4 is equal to 4, and "dog" is equal to "dog"

("blue", -1) < ("purple", 1)        
// OK, evaluates to true

("blue", false) < ("purple", true)  
// Error because < can't compare Boolean values
 ```
 * Nil-Coalescing operator `a ?? b `
   * unwraps an optional `a` if it contains a value and returns `b` if `a` is `nil`
   * in other words, `a != nil ? a : b`
  ```swift
   let defaultColorName = "red"
   var userDefinedColorName: String?   // defaults to nil
   var colorNameToUse = userDefinedColorName ?? defaultColorName
    // userDefinedColorName is nil, so colorNameToUse is set to the default of "red"

    userDefinedColorName = "green"
    colorNameToUse = userDefinedColorName ?? defaultColorName
    // userDefinedColorName isn't nil, so colorNameToUse is set to "green"
   ```
   * Range Operator
1. Closed Range Operator`(a...b)` : `a`, `a+1`, `a+2` ... `b-1`, `b`
```swift
     for index in 1...5 {
        print("\(index) times 5 is \(index * 5)")
    }  
    // 1 times 5 is 5
    // 2 times 5 is 10
    // 3 times 5 is 15
    // 4 times 5 is 20
    // 5 times 5 is 25
```

   2. Half-Open Range Operator`(a...<b)`: not including `b`
  ```swift
    let names = ["Anna", "Alex", "Brian", "Jack"]
    let count = names.count
    for i in 0..<count {
        print("Person \(i + 1) is called \(names[i])")
    }
    // Person 1 is called Anna
    // Person 2 is called Alex
    // Person 3 is called Brian
    // Person 4 is called Jack
```

3. One-Sided Ranger Operator : continue as far as possible in one direction  
```swift
    let names = ["Anna", "Alex", "Brian", "Jack"]
    for name in names[2...] {
        print(name)
    }
    // Brian
    // Jack

    for name in names[...2] {
        print(name)
    }
    // Anna
    // Alex
    // Brian

    for name in names[..<2] {
        print(name)
    }
    // Anna
    // Alex
```
* check whether a one sided range contains a particular value
```swift
let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true
```


