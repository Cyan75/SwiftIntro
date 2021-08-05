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




## 3. Capturing Values