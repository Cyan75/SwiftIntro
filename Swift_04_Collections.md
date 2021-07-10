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
    ``` 
    * Because all values in the array literal are of the same type, Swift can infer that Set<String> is the correct type to use for the favoriteGenres variable.
    * Due to type inference, initialisation with literals does not need type specification
    ```swift
    var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
    ```


