# Functions
## 1. Defining and Calling
```swift
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
```
* parameter : String `person`
* return type(`->`) : String

## 2. Function Parameters and Return Values
* Functions w/o Parameters
```swift
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Prints "hello, world"
```
* Functions w/ multiple Parameters
  * Function parameters are constant by default
```swift
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// Prints "Hello again, Tim!"
```
* Functions w/o returning values : no return arrow 
```swift
func greet(person: String) {
    print("Hello, \(person)!")
}
greet(person: "Dave")
// Prints "Hello, Dave!"
```
* the return type can be ignored when it is called
```swift
func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but doesn't return a value
```
* Functions w/ Multiple Returning Values : returning a tuple
```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
```
```swift
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"
```

## 3. Optional Tuple Return Types
* If the returned tuple has the potential to be `nil`, you can use an optional tuple return type with a question mark.
  * this handles an empty array safely
```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
```
```swift
if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// Prints "min is -6 and max is 109"
```
* Functions w/ an Implicit Return :  any function with one return line can omit the `return`
```swift
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "Dave"))
// Prints "Hello, Dave!"

func anotherGreeting(for person: String) -> String {
    return "Hello, " + person + "!"
}
print(anotherGreeting(for: "Dave"))
// Prints "Hello, Dave!"
```

## 4. Function Argument Labels and Parameter Names
>* Argument Label : used when calling the function(default : parameter name)
>* Parameter Name : used in the implementation of the function(default : parameter name)
```swift
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)
```
* Specifying Argument Lables
```swift
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}
```
```swift
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."
```
* Omitting Argument Labels : use underscore `_`
```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)
```
* Default Parameter Values
  * place parameters w/o default values first : more important
  * then, place parameters with default values
```swift
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
```
* Variadic Parameter(`...`)
  * can be passed  a varying number of input values when the function is called
  * the value passed to a variadic parameter are made available within the functions's body as an array of the appropriate type
  *  a function can have multiple variadic parameters
  *  The first parameter that comes after a variadic parameter must have an argument label to avoid ambiguity
  ```swift
  func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
  }
  arithmeticMean(1, 2, 3, 4, 5)
  // returns 3.0, which is the arithmetic mean of these five numbers
  arithmeticMean(3, 8.25, 18.75)
  // returns 10.0, which is the arithmetic mean of these three numbers
  ```
* In-Out Parameters(`inout`)
  * to 'un-constantise' function parameters after the function call has ended 
  * only variables
  * no constants or literals
  * place an ampersand(`&`) directly before a variable's name when you pass it as an argument to an in-out parameter
  * inout parameters cannot have default values
  * variadic parameteres cannot be marked as inout
  ```swift
  func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
  }
  ```
  ```swift
  var someInt = 3
  var anotherInt = 107
  swapTwoInts(&someInt, &anotherInt)
  print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
  // Prints "someInt is now 107, and anotherInt is now 3"
  ```

## 5. Function Types
* parameters and return type 
  * “A function that has two parameters, both of type Int, and that returns a value of type Int.” or `(Int, Int) -> Int`
  ```swift
  func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
  }
  func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
  }
  ```
  * `() -> Void`
  ```swift
  func printHelloWorld() {
    print("hello, world")
  }
  ```
* Using Function Types 
  * defining a constant or cariable to be of a function type
  ```swift
  var mathFunction: (Int, Int) -> Int = addTwoInts
  ``` 
  * calling the assigned function
  ```swift
  print("Result: \(mathFunction(2, 3))")
  // Prints "Result: 5"
  ```
  * A different function with the same matching type can be assigned to the same variable, in the same way as for nonfunction types
  ```swift
  mathFunction = multiplyTwoInts
  print("Result: \(mathFunction(2, 3))")
  // Prints "Result: 6"
  ```
* Function Types as Parameter Types  
  * passing function types to another another function
  * leave some aspects of a function's implentation for the caller to provide when it calls
  ```swift
  func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
  }
  printMathResult(addTwoInts, 3, 5)
  // Prints "Result: 8"
  ```
* Function Types as Return Types
  * write a function type right after `->`
  ```swift
  func stepForward(_ input: Int) -> Int {
    return input + 1
  }
  func stepBackward(_ input: Int) -> Int {
    return input - 1
  }
  ```
  ```swift
  func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
  }
  ```
  ```swift
  var currentValue = 3
  let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
  // moveNearerToZero now refers to the stepBackward() function
  ```
  ```swift
  print("Counting to zero:")
  // Counting to zero:
  while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
  }
  print("zero!")
  // 3...
  // 2...
  // 1...
  // zero!
  ```

## 6.Nested Functions
* local functions in the body of other functions
* an enclosing function can return one of its nested functions
```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
```



