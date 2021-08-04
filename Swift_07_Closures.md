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
* The Sorted Method(`sorted(by:)`)
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