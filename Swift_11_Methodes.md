# Methods
> * methods are functions that are associated with a particular type
> * Classes, structures, and enumerations can define methods

## 1. Instance Methods
* Instance Methods
  * functions belong to instances of a particular class, structure, or enumeration
  * support functionality of those instance by providing ...
    * ways to access and modify instance properties
    * functionality related to the instance's prupose
  * exactly the same syntax as functions
  * are written within the opening and closing braces of the type it belongs to
  * it has implicit access to all other instance methods and properties of that type
  * can be called only on a specific instance of the type it belongs to
  * it cannot be called in isolation without an existing instance
  ```swift
  class Counter {
      var count = 0
      func increment() {
          count += 1
      }
      func increment(by amount: Int) {
          count += amount
      }
      func reset() {
          count = 0
      }
  }
  ``` 
  ```swift
  let counter = Counter()
  // the initial counter value is 0
  counter.increment()
  // the counter's value is now 1
  counter.increment(by: 5)
  // the counter's value is now 6
  counter.reset()
  // the counter's value is now 0
  ```
* The Self Property
