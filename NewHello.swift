

func print(){
    print("Hello World!")
}
print()

var a = 10
print("a = \(a)")

var b : String = "20"   
print("b = \(b)")

let c : Int = 30;
print("c = \(c)")

typealias newVariable = Int

var d :newVariable  = 40
print("d = \(d)")
//tuple
var tag = ("Name", "Cyan")
print("tag = \(tag)")

var (typed, userInput) = tag
print(typed)
print(userInput)
print("His name is \(userInput)")
print("His name is \(tag.1)")

var e : Int?
print("e = \(e)")
e = 50
print("e = \(e)")

var f : Int?
//f = 55
if (f != nil) {
    print("f = \(f)")    
}
else {
    print("f = \(f)")
}