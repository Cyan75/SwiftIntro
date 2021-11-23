# Error Handling
## 1. Representing and Throwing Errors
* `Error` Protocol and enumeration
```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
```
  * Throwing an error : something unexpected happened and the normal flow of execution cannot continue
  ```swift
  throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
  ``` 
## 2. Handling Errors
* a thrown error has to be handled
* Error Handling
  1. propatating the error from a function to the code that calls that function
  2. `do-catch` statement
  3. an optional value 
  4. assert that the error will not occur 
* use `try`, `try?`, or `try!` to identify places that can throw errors
### 1. Propagating Errors Using Throwing Functions
* `throws` : a function, method or initialiser can throw an error
  * the function is called throwing function
```swift
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
```
* a throwing function propagates errors that are thrown inside of it to the scope from which it is called
* only throwing functions can propagate errors
```swift
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}
``` 
* `vend(itemNamed:)` throws an appropriate `VendingMachineError` if the requested item is not available, is out of stock, or has a cost that exceeds the cureent deposited amount
* `guard` : exit the method early and throw appropriate errors if any of the requirements are not met
* an item will be vended only if all the requirements are met, because `throw` immediately transfers program control

* any code that calls `vend(intemNamed:)` must handle the errors
  * using either `do-catch`, or `try?`, or `try!`
```swift
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
``` 
* Throwing initialisers
```swift
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
```
### 2. Handling Errors Using `do-catch`
* if an error is thrown by the code in the `do` clause, it is matched against the `catch` clauses to determine which one of them can handle the error 
```swift
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch pattern 3, pattern 4 where condition {
    statements
} catch {
    statements
}
```
* if a catch clause does not have a `pattern`, the clause matches any error and binds the error to a local constant named `error`
```swift
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."
```
* if an error is thrown, execution immediately transfers to the `catch` clauses
* `catch` clauses decide whether to allow propagation to continue
* when no pattern is matched, the error gets caught be the final `catch` clause and is bound to a local `error` constant
  * the error propagates to the surrounding scope
* a propagated error must be handled by some surrounding scope
  * nonthrowing function : an enclosing `do-catch` 
  * throwing function
    * an enclosing `do-catch` 
    * the caller
  * a runtime error takes place if the error propagates to the top level scope without being handled
  ```swift
  func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
  }

  do {
    try nourish(with: "Beet-Flavored Chips")
  } catch {
      print("Unexpected non-vending-machine-related error: \(error)")
  }
  // Prints "Couldn't buy that from the vending machine."
  ```
  * `nourish(with:)` handles the error by printing a message
    * in case it does not, the error caught by the general `catch` clause
  * listing several related errors after `catch`
  ```swift
  func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
  }
  ```
  * if any of three listed errors are thrown, this `catch` clause handles them by printing message

### 3. Converting Errors to Optional Values
* if an error is thrown while evaluating the `try?`, the value of the expression is `nil`
```swift
func someThrowingFunction() throws -> Int {
    // ...
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
```
  * `someThrowingFunction()` throws an error to set `x` and `y` to be `nil`.
    * otherwise, `x` and `y` is the value that the function returned
  * `x` and `y` are optionals whatever type `someThrowingFunction()` returns
* `try?`: provides concise and consistent error handling
```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```

### 4. Disabling Error Propagation
* use `try!` to disable error propagation
  * wrap the call in a runtime assertion that no error will be thrown
  * a runtime error takes place if an error actually is thrown
  * when the user know that a throwing function or method will not throw an error at runtime
```swift
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```

## 3. Specifying Cleanup Actions
* `defer` : execute the code just before code execution leaves the current block of code
  * defers execution until the current scope is exited
  * take care of any necessary cleanup thar should be performed
  * how the code execution left the code block does not matter
    * whether by `return` or `break` is not important
  * may not contain any code that would transfer control out of the statements
    * by `break`, `return` or by throwing an error
* defered actions are executed in the reverse order that they are written in the source code
  * the first `defer` statement executes last
  * the second `defer` statement executes second to last
  * the last `defer` statement executes executes first
```swift
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
```
* defer statement : ensures that the `open(_:)` has a corresponding call to `close(_:)`
