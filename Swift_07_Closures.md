# Closures
> * closures are self-contained blocks of functionality that can be passed around and used in the code
> * siliar to lambdas in other programming languages
> * can capture and store references to any constants and vaiables from the context in which they are defined
> * Three forms of closures
>    * Global functions : have a name, do not capture any values
>    * Nested functions : have name, can capture values from their enclosing functions
>    * Closure expressions : no name, in a lightweight syntax that can capture values from surrounding contex
>  * Swift Closure features
>     * Inferring parameter and return value types from context
>     * Implicit returns from single-expression closures
>     * Shorthand argument names
>     * Trailing closure syntax
## 1. Closure Expressions
* The Sorted **Method**(`sorted(by:)`)
  * returns a new array of the same type and size as the old one
  * original array is not modified
  * the sorting closure needs to return true if the first value should appear before the second value
```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
```
```swift
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
```
* Closure Expression Syntax
  * general form 
    ```swift
    { (parameters) -> return type in
        statements
    }
    ```
  * parameters in closure expression syntax can be in-out, variadic, or tuples
  * parameters in closure expression syntax cannot have a default value
  ```swift
  reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
  })
  ```
  * `in` : the definition of the closure's parameters and return type has finished, and the body of the closure is about to begin
  ```swift
  reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
  ```
* Infering Type From Context
  * the function type of `sorted` is definite so it can be omitted  (String, String) -> Bool
  ```swift
  reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
  ```
* Implicit Returns from Single-Expression Closures
  * Single-expression closures can implicitly return the result of their single expression by omitting the `return` keyword
  ```swift
  reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
  ```
* Shorthand Argument Names
  * shorthand argument : `$0`,`$1`,`$2`...
  * you can omit the closure's argument list from its definition
  ```swift
  reversedNames = names.sorted(by: { $0 > $1 } )
  ```  
  `$0` and `$1` are both of type String

* Operator Methods
  * Swift’s String type defines its string-specific implementation of the greater-than operator (`>`) as a method that has two parameters of type String, and returns a value of type Bool
  ```swift
  reversedNames = names.sorted(by: >)
  ```

## 2. Trailing Closures
* passing a closure to a function's final argument : TOO LONG!
* you don’t write the argument label for the first closure as part of the function call
* A function call can include multiple trailing closures
```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
```
* the string-sorting closure can be written outside the `sorted(by:)` method's parentheses as a trailing closure
```swift
reversedNames = names.sorted() { $0 > $1 }
```
* if a closure expression is the only argument of the function or method, `()` can be omitted
```swift
reversedNames = names.sorted { $0 > $1 }
```

* `map(_:)` : method of Array type, taking a closure expression as its single argument
  * returns a new array containing all of the new mapped values
  * in the same order as their corresponding values in the original array
  * to create a new array `["OneSix", "FiveEight", "FiveOneZero"]`
```swift
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
```
  * pass a closure expression to the array's `map(_:)` method as a trailing closure
```swift
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]
```
  * `!` after digitName : return an optional value to indicate that the dictionary lookup can fail if the key does not exist
  * the string retrieved from digitNum dictionary is added to the front of output
  * if a function takes multiple closures you omit the argument label for the first trailing closure and you label the remaining closures
  ```swift
   func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
      if let picture = download("photo.jpg", from: server) {
         completion(picture)
      } else {
        onFailure()
      }
  }
  ```
  * when you call this function to load a picsture, you provide two closures :  
    * a completion handler that displays a picture after a successful download
    * a error handler that displays an error to the user
    ```swift
    loadPicture(from: someServer) { picture in
    someView.currentPicture = picture
    } onFailure: {
        print("Couldn't download the next picture.")
        }
    ```

## 3. Capturing Values
> a closure can acpture constants and vaiables from the surrounding context in which it is defined

* a nested function is a closure that can capture values
  * a nested function can capture any of its outer function's arguments, any constants, and variables
  ```swift
  func makeIncrementer(forIncrement amount: Int) -> () -> Int {
      var runningTotal = 0
      func incrementer() -> Int {
          runningTotal += amount
          return runningTotal
      }
      return incrementer
  }
  ```
  * return type of `makeIncrementer` is `() -> Int` (a function returning a function)
  * `makeIncrementer` defines an integer called `runningTotal` to store the current running total fo the increment that will be returned.
  ```swift
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  ```
  * `increment` does not have any parameter, but it referes to `runningTotal` and `amount` from within its function body
  ```swift
  let incrementByTen = makeIncrementer(forIncrement: 10)
  ```  
  ```swift
  incrementByTen()
  // returns a value of 10
  incrementByTen()
  // returns a value of 20
  incrementByTen()
  // returns a value of 30
  ```
  * creating a second incrementer will 
  ```swift
  let incrementBySeven = makeIncrementer(forIncrement: 7)
  incrementBySeven()
  // returns a value of 7
  ```
  * calling the original incrementer `incrementByTen` again continues to increment its own runningTotal vairable. 
  * does not affect the variable captured by `incrementBySeven`
  ```swift
  incrementByTen()
  // returns a value of 40
  ```

## 4. Closure Are Reference Types
* Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure
* if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure
```swift
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 50

incrementByTen()
// returns a value of 60
```
 * calling `alsoIncrementByTen` is the same as calling `incrementByTen`
 * both of them refer to the same closure, they both increment and return the same running total.

## 5. Escaping Closures
> a closure is said to escape afunction when the closure is passed as an argument to the function, but it is called after the function returns
> `@escaping`

* stored in a variable defined outside the function
  * the function returns after it starts the operation, but the closure is not called until the operation is completed
  * the closure needs to escape, to be called later
  ```swift
  var completionHandlers: [() -> Void] = []
  func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
      completionHandlers.append(completionHandler)
  }
  ```
  * If you didn’t mark the parameter of this function with @escaping, you would get a compile-time error
* normally a closure captures variables implicitly by using them in the body of the closure

* An escaping closure that refers to `self` needs special consideration if `self` refers to an instance of a class
  * Capturing `self` in an escaping closure makes it easy to accidentally create a strong reference cycle : see ARC
  * if you want to capture `self`, write `self` explicitly when you use it
  ```swift
  func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
  }

  class SomeClass {
      var x = 10
      func doSomething() {
          someFunctionWithEscapingClosure { self.x = 100 }
          someFunctionWithNonescapingClosure { x = 200 }
      }
  }

  let instance = SomeClass()
  instance.doSomething()
  print(instance.x)
  // Prints "200"

  completionHandlers.first?()
  print(instance.x)
  // Prints "100"
  ```
  * captures `self` by including it in the closure's capture list, and then refers to `self` implicitly
  ```swift
  class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
  }
  ```
  * `self` is an instance of a structure or an enumeration
  * an escaping closure cannot apture a mutable reference to `self` when `self` is an instance of a structure or an enumeration
  ```swift
  struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
        someFunctionWithEscapingClosure { x = 100 }     // Error
    }
  }
  ```
  * escaping closures cannot capture  a mutable reference to `selfs` for structures

## 6. Autoclosures
* automatically create to wrap an expression that is being passed as an argument to a function
* autoclosures do not take any arguments 
* an autoclosure returns the value of the expression that is wrapped inside of it
* braces around a functions can be omitted
* it is common to call functions that take autoclosures
* it is not common to implement functions that take autoclosures
* evaluation delay : the code inside inside the autoclosure is not run until the closure is called
  * benefit : can control when the code is evaluated
```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5" still..

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4" at last!
```
* remove action is not done yet until the closure is actually called
```swift
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"
```
* `serve(customer:)` takes an autoclosure by making its parameter's type with the `@autoclosure` attribute
* it behaves as if it took a `String` argument instead of a closure
  * the argument is automatically converted to a closure because the `customerProvider` parameter's type is marked with the `@autoclosure` attribute
```swift
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"

```
* However, excessive use of autoclosure can make your code hard to understand
* **escaping autoclosures**(`@autoclosure` and `@escaping`)
```swift
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"
```
* the `collectCustomerProviders(_:)` appends the closure to the `customerProviders`
* `customerProviders` is declared outside the scope of the function :  the closures in the array can be executed after the function returns
*  the value of the `customerProvider` argument must be allowed to escape the function’s scope
