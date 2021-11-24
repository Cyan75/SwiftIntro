# Concurrency
* Asynchronous code : one piece of the program executes at a time
  * can be suspended and resumed later
  * make progress on short-term operations
* Parallel code : multiple pieces of code run simultaneously

* adding concurrency to the code
  * enable compile-time checking
  * may make the execution slow and buggy 
* Concurrent code without  Swift language support
```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
```
* ## Defining and Calling Asynchronous Functions `async`
  * asynchronous : can be suspended while it is partway through execution
    * synchronous : either run to completion, throw error, or never return
  * asynchronous functions can pause in the middle when it is waiting for something
  * mark places inside the body of an asynchronous function where execution can be suspended
  * `async` after the parameters
  ```swift
  func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
  }
  ```
  * `async` `throw` : a throwing asynchronous function
  * execution suspends until that method returns
  * `await` : every possible suspension point
    * suspension is never implicit or preemptive
  * inside an asynchronous method, execution only suspends when another asynchronous method is called
  ```swift
  let photoNames = await listPhotos(inGallery: "Summer Vacation")
  let sortedNames = photoNames.sorted()
  let name = sortedNames[0]
  let photo = await downloadPhoto(named: name)
  show(photo)
  ```