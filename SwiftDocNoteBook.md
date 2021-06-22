### Overview
* Adopting Modern Programming Patterns
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


### The Basics
* Fundamental Types(from C)
  * `Int`
  *  `Double`
  *  `Float`
  *  `Bool`
  *  `String`
* Primary Collection Types
  * `Array`
  * `Set`
  * `Dictionary` 
* Constants and Variables
  * Constant : use `let` as much as possible
    ```swift
    let maximumNumberOfLoginAttempts = 10
    ``` 
    * Variable : 
    ```swift
    var currentLoginAttempt = 0
    var x = 0.0, y = 0.0, z = 0.0
    ``` 
 * Type Annotation   
    ```swift
    var welcomMessage: String
    var red, green, blue: Double
    ``` 
* unicode characters are allowed for constant and variable names
    ```swift
    let 이름 = "Cyan"
    var 😂 = 2.871
    ``` 
* `print(_:separator:terminator:)` 
  ```swift
    var friendlyWelcome = "Hello!"
    friendlyWelcome = "Bonjour!"
    // friendlyWelcome is now "Bonjour!"
    print(friendlyWelcome)
    // Prints "Bonjour!"
  ```    
  * type inference
  ```swift
  let meaningOfLife = 42
  // meaningOfLife is inferred to be of type Int
  ```
  * Numeric Literals
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
