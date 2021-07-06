# Strings
* ## String Literals
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
    
* ## Initialise Empty Strings    
  ```swift
  var emptyString = ""               // empty string literal
  var anotherEmptyString = String()  // initializer syntax
  // these two strings are both empty, and are equivalent to each other   

  if emptyString.isEmpty {
    print("Nothing to see here")
  }
   // Prints "Nothing to see here"
  ```
* ## String Mutability
  ```swift
  var variableString = "Horse"
  variableString += " and carriage"
  // variableString is now "Horse and carriage"

  let constantString = "Highlander"
  constantString += " and another Highlander"
  // this reports a compile-time error - a constant string cannot be modified
  ```
* ## Swift Strings Are Value Types
  * 

