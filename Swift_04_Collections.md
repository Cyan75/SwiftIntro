# Collections
* they are mutable: can be changed by adding, removing etc.
* ## Arrays
  * ordered list of values
  * Empty Array
  ```swift
  var someInts: [Int] = []
  print("someInts is of type [Int] with \(someInts.count) items.")
  // Prints "someInts is of type [Int] with 0 items."

  someInts.append(3)
  // someInts now contains 1 value of type Int
  someInts = []
  // someInts is now an empty array, but is still of type [Int]

  ``` 
  * Array with Default values
  ```swift
  var threeDoubles = Array(repeating: 0.5, count: 3)
  // threeDoubles is of type [Double], and equals [0.5, 0.5, 0.5]
  ``` 
  * Adding Two arrays
  ```swift
  var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
  // anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

  var sixDoubles = threeDoubles + anotherThreeDoubles
  // sixDoubles is inferred as [Double], and equals [0.5, 0.5, 0.5, 2.5, 2.5, 2.5]
  ```

  * Creating an Array with an Array Literal
    * Thanks to Swift’s type inference, you don’t have to write the type of the array if you’re initializing it with an array literal containing values of the same type. The initialization of shoppingList could have been written in a shorter form instead:
  ```swift
  var shoppingList: [String] = ["Eggs", "Milk"]
  // shoppingList has been initialized with two initial items

  //or
  var shoppingList = ["Eggs", "Milk"]
  ```
  * Accessing and Modifying an Array
    1. counting the number of items:`.count`
    ```swift
    print("The shopping list contains \(shoppingList.count) items.")
    // Prints "The shopping list contains 2 items."
    ``` 
    2. check whether empty
    ```swift
    if shoppingList.isEmpty {
      print("The shopping list is empty.")
      } else {
          print("The shopping list isn't empty.")
          }
          // Prints "The shopping list isn't empty."
    ```
    3. add an item to the end:`.append` or `+=`
    ```swift
    shoppingList.append("Flour")
    // shoppingList now contains 3 items, and someone is making pancakes

    //or

    shoppingList += ["Baking Powder"]
    // shoppingList now contains 4 items
    shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
    // shoppingList now contains 7 items
    ```
    4. accessing by subscript syntax with index and range
    ```swift
    var firstItem = shoppingList[0]
    // firstItem is equal to "Eggs"

    shoppingList[0] = "Six eggs"
    // the first item in the list is now equal to "Six eggs" rather than "Eggs"

    shoppingList[4...6] = ["Bananas", "Apples"]
    // shoppingList now contains 6 items
    ```
    5. add an item into the array at specific index : `insert(_:at:)`
    ```swift
    shoppingList.insert("Maple Syrup", at: 0)
    // shoppingList now contains 7 items
    // "Maple Syrup" is now the first item in the list
    ```
    6. remove an item : `remote(at:)`, remove the last
    ```swift
    let mapleSyrup = shoppingList.remove(at: 0)
    // the item that was at index 0 has just been removed
    // shoppingList now contains 6 items, and no Maple Syrup
    // the mapleSyrup constant is now equal to the removed "Maple Syrup" string

    let apples = shoppingList.removeLast()
    // the last item in the array has just been removed
    // shoppingList now contains 5 items, and no apples
    // the apples constant is now equal to the removed "Apples" string
    ``` 
  * Iterating Over an Array  
    * for-in loop
    * `enumerated()` : returns a tuple composed of an integer and the item
    ```swift
    for item in shoppingList {
        print(item)
    }
    // Six eggs
    // Milk
    // Flour
    // Baking Powder
    // Bananas

    for (index, value) in shoppingList.enumerated() {
        print("Item \(index + 1): \(value)")
    }
    // Item 1: Six eggs
    // Item 2: Milk
    // Item 3: Flour
    // Item 4: Baking Powder
    // Item 5: Bananas
    ``` 
* ## Sets
  * Hash Values for Set Types
    * A type must be hashable : in order to be stored in a set
    * a hash value is an Int
    * All basic types of Swift(String, Int, Doubble, Bool) are hashable
  * Set Type Syntax
    * *Set<Element>* form, no shorthand form
  * Creating and Initialising an Empty Set
    ```Swift
    var letters = Set<Character>()
    print("letters is of type Set<Character> with \(letters.count) items.")
    // Prints "letters is of type Set<Character> with 0 items."
    ``` 
  * Creating a Set with an Array Literal
    ```swift
    var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
    // favoriteGenres has been initialized with three initial items

    var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
    ``` 
    * Because all values in the array literal are of the same type, Swift can infer that Set<String> is the correct type to use for the favoriteGenres variable.
    * Due to type inference, initialisation with literals does not need type specification

  * Accessing and Modifying a Set
    1. `.count` : read-only 
    ```swift
    print("I have \(favoriteGenres.count) favorite music genres.")
    // Prints "I have 3 favorite music genres."
    ```
    2. `isEmpty`
    ```swift
    if favoriteGenres.isEmpty {
      print("As far as music goes, I'm not picky.")
    } else {
      print("I have particular music preferences.")
      }
      // Prints "I have particular music preferences."
    ```
    3. `insert(_:)`
    ```swift
    favoriteGenres.insert("Jazz")
    // favoriteGenres now contains 4 items
    ```
    4. `remove(_:)` and `removeAll()`
    ```swift
    if let removedGenre = favoriteGenres.remove("Rock") {
      print("\(removedGenre)? I'm over it.")
    } else {
      print("I never much cared for that.")
      }
      // Prints "Rock? I'm over it."
    ```
    5. `contains(_:)`
    ```swift
    if favoriteGenres.contains("Funk") {
      print("I get up on the good foot.")
      } else {
        print("It's too funky in here.")
        }
        // Prints "It's too funky in here."
    ``` 
  * Iterating Over a Set
    * `for-in` loop
    ```swift
    for genre in favoriteGenres {
      print("\(genre)")
    }
    // Classical
    // Jazz
    // Hip hop
    ```
    * `sorted()` : as Swift sets do not have a defined ordering, 
    ```swift
    for genre in favoriteGenres.sorted() {
      print("\(genre)")
      }
      // Classical
      // Hip hop
      // Jazz
    ```
* ## Performing Set Operations
  * Fundamental Set Operations
    1. `intersection(_:)` : creat a new set with only the values common to both sets
    2. `symmetricDifference(_:)` : create a new set with values in either set, but not both
    3. `union(_:)` : create a new set with all of the values in both sets
    4. `subtracting(_:)` create a new set with values not in the specified set
    ```swift
    let oddDigits: Set = [1, 3, 5, 7, 9]
    let evenDigits: Set = [0, 2, 4, 6, 8]
    let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

    oddDigits.union(evenDigits).sorted()
    // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    oddDigits.intersection(evenDigits).sorted()
    // []
    oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
    // [1, 9]
    oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
    // [1, 2, 9]
    ```
  * Set Membershop and Equality 
    1. `==` (is equal) : determine whether two sets contain all of the same values
    2. `isSubset(of:)` : determine whether all of the values of a set are contained in the specified set
    3. `isSuperset(of:)` : determine whether a set contains all of the values in a specified set
    4. `isStrictSubset(of:)` or `isStrictSuperset(of:)` : determine whether a set is a subset or superset, but not equal to, a specified set
    5. `isDisjoint(with:)` : determine whether two sets have no values in common
    ```Swift
    let houseAnimals: Set = ["🐶", "🐱"]
    let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
    let cityAnimals: Set = ["🐦", "🐭"]

    houseAnimals.isSubset(of: farmAnimals)
    // true
    farmAnimals.isSuperset(of: houseAnimals)
    // true
    farmAnimals.isDisjoint(with: cityAnimals)
    // true
    ```
* ## Dictionaries
> association between the same type and values of the same type with no defined ordering
> each value is associated with a unique key
  * Creating an Empty Dictionary : if the context provides type information, an empty dictionay can be created with an empty literal
  ```swift
  var namesOfIntegers: [Int: String] = [:]
  // namesOfIntegers is an empty [Int: String] dictionary

  namesOfIntegers[16] = "sixteen"
  // namesOfIntegers now contains 1 key-value pair
  namesOfIntegers = [:]
  // namesOfIntegers is once again an empty dictionary of type [Int: String]
  ```
  * Creating a Dictionary with a Dictionary Literal
    ```swift
    var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    ```
    * Swift can infer that [String: String] is the correct type to use for the airports dictionary.
  * Accessing and Modifying a Dictionary
    1. `.count`
    ```swift
    print("The airports dictionary contains \(airports.count) items.")
    // Prints "The airports dictionary contains 2 items."
    ``` 
    1. `isEmpty`
    ```swift
    if airports.isEmpty {
      print("The airports dictionary is empty.")
      } else {
        print("The airports dictionary isn't empty.")
        }
        // Prints "The airports dictionary isn't empty."
    ```
    1. add an item with subscript syntax
    ```swift
    airports["LHR"] = "London"
    // the airports dictionary now contains 3 items
    ```
    1. change an item with subscript syntax
    ```swift
    airports["LHR"] = "London Heathrow"
    // the value for "LHR" has been changed to "London Heathrow"
    ```
    1. change an item with `updateValue(_:forKey:)`
    ```swift
    if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
      print("The old value for DUB was \(oldValue).")
    }
    // Prints "The old value for DUB was Dublin."
    ```
    1. remove value with subscript syntax
    ```swift
    airports["APL"] = "Apple International"
    // "Apple International" isn't the real airport for APL, so delete it
    airports["APL"] = nil
    // APL has now been removed from the dictionary
    ```
    1. remove value with `removeValue`
    ```swift
    if let removedValue = airports.removeValue(forKey: "DUB") {
      print("The removed airport's name is \(removedValue).")
      } else {
        print("The airports dictionary doesn't contain a value for DUB.")
        }
        // Prints "The removed airport's name is Dublin Airport."
    ```
  * Iterating over a Dictionary 
    * `for-in` loop
    ```swift
    for (airportCode, airportName) in airports {
      print("\(airportCode): \(airportName)")
      }
      // LHR: London Heathrow
      // YYZ: Toronto Pearson
    ```
    * `keys` and `values`
    ```swift
    for airportCode in airports.keys {
      print("Airport code: \(airportCode)")
      }
      // Airport code: LHR
      // Airport code: YYZ
      
      for airportName in airports.values {
        print("Airport name: \(airportName)")
        }
        // Airport name: London Heathrow
        // Airport name: Toronto Pearson
    ```
    * `keys`, `values`, and an API that takes an Array instance
    ```swift
    let airportCodes = [String](airports.keys)
    // airportCodes is ["LHR", "YYZ"]
    
    let airportNames = [String](airports.values)
    // airportNames is ["London Heathrow", "Toronto Pearson"]
    ```
    * use `sorted()` to order in a specific order