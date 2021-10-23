# Deinitialisation `deinit`
## 1. How Deinitialisation Work
*  Swift automatically deallocates the instances when they are no longer needed
   *  Swift handles the memory through ARC(automatic reference counting)
   * in general, some manual additional resource cleanup is not necessary
   * when a user works with one's own resources, the user might need to perform some additional cleanup
```swift
deinit {
    // perform the deinitialization
}
```
* Deinitialisers are called automatically
* Superclass deinitialisers 
  * are inherited by their subclasses
  * are called automatically at the end of a subclass deinitialiser implementation
  * are always called even if a subclass does not provide its own deinitialiser
* a deinitialiser can access all properties of the instance it is called on and can modify its behaviour based on those properties

## 2. Deinitialisers in Action
```swift
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}
```
* there can only be one `Bank` in the game
* `distribute(coins:)` checks that there are enough coins in the bank before distributing them
* `receive(coins:)` simply adds the received number of coins back into the bank's coin store
```swift
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
```
* each `Player` instance is initialised with a starting allowance of a specified number of coins from the bank duting initialisation
  * a `Player` instance may receive fewer than that number if not enough coins are available
  * `Player` also implements a deinitialiser which is called just before a `Player` instance is deallocated
* `win(coins:)` retrieves a certain number of coins from the bank and add them to the plyer's purse
```swift
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"
```
* a new `Player` instance is created, with a request for 100 coins if they are available
  * This `Player` instance is stored in an optional Player variable called `playerOne`
  * when its `coinsInPurse` property is accessed to print its default number of coins, and whenever its `win(coins:)` is called
  ```swift
  playerOne!.win(coins: 2_000)
  print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
  // Prints "PlayerOne won 2000 coins & now has 2100 coins"
  print("The bank now only has \(Bank.coinsInBank) coins left")
  // Prints "The bank now only has 7900 coins left"
  ```
  * the player has won 2,000 coins
  * the player’s purse now contains 2,100 coins
  * the bank has only 7,900 coins left
  ```swift
  playerOne = nil
  print("PlayerOne has left the game")
  // Prints "PlayerOne has left the game"
  print("The bank now has \(Bank.coinsInBank) coins")
  // Prints "The bank now has 10000 coins"
  ```
  * the player left the game
    * sets `playerOne` to nil : no `Player` instance
    * no other properties or variables are still referring to the `Player` instance
      * it is deallocated in order to free up its memory
      * just before this happens, its deinitialiser is called automatically, its coins are returned to the bank  
