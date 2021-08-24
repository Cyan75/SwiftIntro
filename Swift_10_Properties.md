# Properties
> Properties associate values with a particular class, structure, or enumeration
> Stored properties store constant and variable values as part of an instance


## 1. Stored Properties
* a stored property is a constant or variable that’s stored as part of an instance of a particular class or structure
  * variable stored properties or constant stored properties
* setting a default value, setting and modifying the initial value are available
```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```
  * `firstValue` is a variable stored property
  * `length` is a constant stored property 

* Stored Propertiies of Constant Structure Instances 
  * the properties of an instance which is assigned to a constant cannot be modified
  ```swift
  let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
  // this range represents integer values 0, 1, 2, and 3
  rangeOfFourItems.firstValue = 6
  // this will report an error, even though firstValue is a variable property
  ```
  * this is because structures are value types
    * all the properties of a constant instance of a value type are constant
  * the properties can be changed in case the instance is of a constant reference type 

* Lazy Stored Properties `lazy`
  * a lazy stored property is a property whose initial value is not calculated until the first time it is used
  * it must be declared to be **variable** 
  * useful when...
    * the initial value for a property is dependent on outside factors which is not known until after an instance's initialisation is complete
    * the initial value for a property requires complex or computationally expensive setup that should not be performed unless or until it is neede
  ```swift
  class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
        // the DataImporter class would provide data importing functionality here
    }
  class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
  }
  let manager = DataManager()
  manager.data.append("Some data")
  manager.data.append("Some more data")
  // the DataImporter instance for the importer property hasn't yet been created
  ```
  * data importing functionality of `DataManager` is provided by `DataImporter` which is assumed to take a nontrivial amount of time to initialise
  * the lazy property `importer` is only created when the `importer` property is first accessed 
  ```swift
  print(manager.importer.filename)
  // the DataImporter instance for the importer property has now been created
  // Prints "data.txt"
  ```
  * a `lazy`-marked property accessed by multiple threads can be initialised multiple times 