# The Basics
* ## Adopting Modern Programming Patterns
  * Variables are always initialised before use
  * Array indices are checked for out-of-bounds errors
  * Integers are checked for overflow
  * Optionals ensure that `nil` values are handled explicitly
    * Optional: a data structure that has an optional value. More strictly, an Optional can either have a value or nothing.
        ```swift
        var name: String?
        var rollNumber: Int!
        ```
    * if it can be `nil` then you need to unwrap to use it
  * Memotry is managed automatically
  * Error handling allows controlled recovery from unexpected failures


# The Basics
* ## Fundamental Types(from C)
  * `Int`
  *  `Double`
  *  `Float`
  *  `Bool`
  *  `String`
* ## Primary Collection Types
  * `Array`
  * `Set`
  * `Dictionary` 
* ## Constants and Variables
  * Constant : use `let` as much as possible
    ```swift
    let maximumNumberOfLoginAttempts = 10
    ``` 
    * Variable : 
    ```swift
    var currentLoginAttempt = 0
    var x = 0.0, y = 0.0, z = 0.0
    ``` 
 * ## Type Annotation   
    ```swift
    var welcomMessage: String
    var red, green, blue: Double
    ``` 
* ## unicode characters are allowed for constant and variable names
    ```swift
    let 이름 = "Cyan"
    var 😂 = 2.871
    ``` 
* ## `print(_:separator:terminator:)` 
  ```swift
    var friendlyWelcome = "Hello!"
    friendlyWelcome = "Bonjour!"
    // friendlyWelcome is now "Bonjour!"
    print(friendlyWelcome)
    // Prints "Bonjour!"
  ```    
  * ## type inference
  ```swift
  let meaningOfLife = 42
  // meaningOfLife is inferred to be of type Int
  ```
  * ## Numeric Literals
    * A *decimal* number, with no prefix : `17`
    * A *binary* number, with a `0b` prefix : `0b10001`
    * An *octal* number, with a `0o` prefix : `0o21`
    * A *hexadecimal* number, with a `0x` prefix : `0x11`
    * exponent decimal`10`, hexadecimal`2`
      * 1.25e2 means 1.25 x 10<sup>2</sup>, or 125.0.
      * 1.25e-2 means 1.25 x 10<sup>-2</sup>, or 0.0125.
      * 0xFp2 means 15 x 2<sup>2</sup>, or 60.0.
      * 0xFp-2 means 15 x 2<sup>-2</sup>, or 3.75.
    * underscore does not affect
    ```swift
    let paddedDouble = 000123.456
    let oneMillion = 1_000_000
    let justOverOneMillion = 1_000_000.000_000_1
    ```
   * Type Conversion : C-type casting
   * TypeAlias : Typedef
    ```swift
    typealias AudioSample = UInt16
    ```
   * Tuple: underscore ignores value, accessible with index, can tag element names
  ```swift
  let http404Error = (404, "Not Found")
  // http404Error is of type (Int, String), and equals (404, "Not Found")
  let (justTheStatusCode, _) = http404Error
  print("The status code is \(justTheStatusCode)")
  // Prints "The status code is 404"

  print("The status code is \(http404Error.0)")
  // Prints "The status code is 404"
  print("The status message is \(http404Error.1)")
  // Prints "The status message is Not Found"

  print("The status code is \(http200Status.statusCode)")
  // Prints "The status code is 200"
  print("The status message is \(http200Status.description)")
  // Prints "The status message is OK"
  ```
* ## Optionals
  * An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.
   ```swift
   let possibleNumber = "123"
  let convertedNumber = Int(possibleNumber)
  // convertedNumber is inferred to be of type "Int?", or "optional Int"
   ```
   * `nil` : set a valueless state
   * `?` : to set the type to be optional
   * `nil` cannot be used with non-optional constants or variables
   * if an optional is defined without a default, it automatically set to `nil`
     ```swift
     var serverResponseCode: Int? = 404
     // serverResponseCode contains an actual Int value of 404
     serverResponseCode = nil
     // serverResponseCode now contains no value
     ``` 
  * If an optional has a value, it’s considered to be “not equal to” `nil`
  * Forced Unwrapping : you can access its underlying value by adding an exclamation point(!) to the end of the optional’s name.
    * nil cannot be unwrapped forcefully
    * **Use this only if the optional certainly contains a value, not nil**
   ```swift
   if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
  }
  // Prints "convertedNumber has an integer value of 123."
   ```
   * **Optional Binding**: check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action.
   ```swift
   if let constantName = someOptional {
     statements
  }

  let possibleNumber = "123"
  let convertedNumber = Int(possibleNumber)
  // convertedNumber is inferred to be of type "Int?", or "optional Int"

  if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
  } else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
  }
  // Prints "The string "123" has an integer value of 123"
   ```
   * if the optional `Int` returned by `Int(possibleNumber)` contains a value, set a new constant called `actualNumber` to the value contained in the optional

   * You can include as many optional bindings and Boolean conditions in a single if statement as you need to, **separated by commas**.
   ```swift
   if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
  }

  if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
  }
   ```
   * Implicitly unwrapped optional : an optional will always have a value, after that value is first set.
     * Declare the optional with `!`
       * whereas forced unwrapping requires `!` when using
     * during class initialisation
     * giving permission for the optional to be force-unwrapped if needed
   ```swift
   let possibleString: String? = "An optional string."
   let forcedString: String = possibleString! // requires an exclamation point

   let assumedString: String! = "An implicitly unwrapped optional string."
   let implicitString: String = assumedString // no need for an exclamation point
   ``` 
     * [Forced Unwrapping vs Implicitly Unwrapping](https://stackoverflow.com/questions/38817494/difference-between-force-unwrapping-optionals-and-implicitly-unwrapped-optionals)
     
* ## Error Handling
  *  a function encounters an error condition throws an error
  ```swift
  func canThrowAnError() throws {
    // this function may or may not throw an error
  }
  ```
  * try-catch 
    ```swift
    do {
      try canThrowAnError()
        // no error was thrown
    } catch {
      // an error was thrown
      }
    ```
* ## Debugging with Assertion
  * When the boolean condition is...
    * true : code execution continues as usual
    * false : the current state of the program is invalid; code execution ends, and your app is terminated
  ```swift
  let age = -3
  assert(age >= 0, "A person's age can't be less than zero.")
  // This assertion fails because -3 isn't >= 0.
  //false, and the assertion fails, terminating the application.
  ```