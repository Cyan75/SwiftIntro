# Strings
* String Literals
  * Multiline String Literals : characters surrounded by three double quotation marks:
  * linebreak: 
   ```swift
   """

   """
   ```
  * also includes indentations
  * Special Characters
    * `\0` : null character
    * `\\` : backslash
    * `\t` : horizontal tab
    * `\n` : line feed
    * `\r` : carriage return
    * `\"` : double quotation mark
    * `\'` : single quotation mark
    * `\u{hexadecimal}` : unicode of hexadecimal
  * String Delimiters `# #` : like <div></div> in HTML
    
* Initialise Empty Strings, check if empty(`.isEmpty`)
  ```swift
  var emptyString = ""               // empty string literal
  var anotherEmptyString = String()  // initializer syntax
  // these two strings are both empty, and are equivalent to each other   

  if emptyString.isEmpty {
    print("Nothing to see here")
  }
   // Prints "Nothing to see here"
  ```
* String Mutability
  ```swift
  var variableString = "Horse"
  variableString += " and carriage"
  // variableString is now "Horse and carriage"

  let constantString = "Highlander"
  constantString += " and another Highlander"
  // this reports a compile-time error - a constant string cannot be modified
  ```
* Swift Strings Are Value Types

* Characters
  ```swift
  for character in "Dog!🐶" {
    print(character)
  }
  // D
  // o
  // g
  // !
  // 🐶
  ```
* Concatenation
  * string, character concatenation: `+`, `+=`
  * appending char to string `string.append("char")`

* Interpolation using backslash`\`
  ```swift
  let multiplier = 3
  let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
  // message is "3 times 2.5 is 7.5"

  print(#"Write an interpolated string in Swift using \(multiplier)."#)
  // Prints "Write an interpolated string in Swift using \(multiplier)."
  ```
* Unicode
  * The letter é can be represented as the single Unicode scalar é (`LATIN SMALL LETTER E WITH ACUTE`, or `U+00E9`)
  * the same letter can also be represented as a pair of scalars—a standard letter e (`LATIN SMALL LETTER E`, or `U+0065`), followed by the COMBINING ACUTE ACCENT scalar (`U+0301`).
   ```swift
   let eAcute: Character = "\u{E9}"                         // é
   let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
   // eAcute is é, combinedEAcute is é

   let precomposed: Character = "\u{D55C}"                  // 한
   let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
   // precomposed is 한, decomposed is 한
   ```
* Counting Characters(`.count`)
  ```swift
  var word = "cafe"
  print("the number of characters in \(word) is \(word.count)")
  // Prints "the number of characters in cafe is 4"
  ```    
* Accessing, modifying
  * Swift strings cannot be indexed by integer values
  * `startIndex`: position of the first character
  * `endIndex`: position after the last character
  * `before:` : 
  * `after:` : 
  * `offsetBy:` : offset after the designated starting point
  * `at:` : at the designated position
  ```swift
  let greeting = "Guten Tag!"
  greeting[greeting.startIndex]
  // G
  greeting[greeting.index(before: greeting.endIndex)]
  // !
  greeting[greeting.index(after: greeting.startIndex)]
  // u
  let index = greeting.index(greeting.startIndex, offsetBy: 7)
  greeting[index]
  // a
  ```
  * Insert and Remove
    * `insert(_:at:)`, `insert(contentsOf:at:)`
   ```swift
   var welcome = "hello"
   welcome.insert("!", at: welcome.endIndex)
   // welcome now equals "hello!"

   welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
   // welcome now equals "hello there!"
   ```
   * `remove(at:)`, `removeSubrange(_:)`
   ```swift
   welcome.remove(at: welcome.index(before: welcome.endIndex))
   // welcome now equals "hello there"

   let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
   welcome.removeSubrange(range)
   // welcome now equals "hello"
   ``` 
* Substrings
  * work with substrings the same way as working with strings
  * short-living: temporarily contains part of the string memory
  ```swift
  let greeting = "Hello, world!"
  let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
  let beginning = greeting[..<index]
  // beginning is "Hello"

  // Convert the result to a String for long-term storage.
  let newString = String(beginning)
  ```
* Comparing Strings
  * use `==`, `!=`
  * prefix and suffix equality: `hasPrefix`, `hasSuffix`
   ```swift
   let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
    ]
    var act1SceneCount = 0
    for scene in roimeoAndJuliet{
        if(scene.hasPrefix("Act 1 ")){
            act1SceneCount += 1
        }
    }
    print("There are \(act1SceneCount) scenes in Act 1")
    // Prints "There are 5 scenes in Act 1"
   ```
* Unicode Representations of Strings
  * unicode scalar in the string are encoded in one of several Unicode-defined encoding forms with small chunks called code units
    * UTF-8 : encode a sting as 8-bit code unit
    * UTF-16 : encode a sting as 16-bit code unit
    * UTF-32 : encode a sting as 32-bit code unit
  ```swift
  let dogString = "Dog‼🐶"
  for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
  }
  print("")
  // Prints "68 111 103 226 128 188 240 159 144 182 "

  for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
  }
  print("")
  // Prints "68 111 103 8252 55357 56374 "
  ```
  * UnicodeScalarView is a collection of values of type Unicode Scalar
  ```swift
  let dogString = "Dog‼🐶"
  for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 8252 128054 "

    for scalar in dogString.unicodeScalars {
        print("\(scalar) ")
    }
    // D
    // o
    // g
    // ‼
    // 🐶

  ```

