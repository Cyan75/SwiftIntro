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
  * `listPhotos(inGallery:)` and `downloadPhoto(named:)` take a relatively long time to complete as they need to make network requests
    * setting them `async` lets the rest of the app's code keep running while the code waits for the picture to be ready
  * what happends during execution of the code
    1. the first line runs up to the first `await` 
       * it calls `listPhotos(inGallery:)` and suspends execution while it waits for that function to return
    2. while execution is suspended, some other concurrent code in the same program runs
       *  e.g. a long-running background task continues updating a list of new photo galleries.
       *  that code also runs until the next `await` or until it completes
    3.  after `listPhotos(innGallery:)` returns this code continues execution 
        * it assigns the value that was returned to `photoNames`
    4. the line defines `sortedNames` and `name` are regular, synchronous code as there is no `await` on these lines
    5. the next `await` marks the call to the `downloadPhoto(named:)` 
       * this code pauses execution again until that function returns,giving other concurrent code an opportunity to run
    6. after `downloadPhoto(named:)` returns, its return value is assigned to `photo` and then passed as an argument when calling `snow(_:)`
  * thread yielding : the suspension points might pauses while waiting for the aynchronous function or method to return
    * Swift suspends the execution of the code on the current thread, runs some other code on that thread
  * asynchronous functions or methods can be called only at certain places in the program 
    * Code in the body of an asynchronous function, method, or property
    * Code in the static `main()` method of a structure, class, or enumeration that’s marked with `@main`
    * Code in a detached child task
* `Task.sleep(_:)` : waits at least the given number of nanoseconds before it returns
  ```swift
  func listPhotos(inGallery name: String) async -> [String] {
    await Task.sleep(2 * 1_000_000_000)  // Two seconds
    return ["IMG001", "IMG99", "IMG0404"]
  }
  ```
* ## Asychronous Sequence

