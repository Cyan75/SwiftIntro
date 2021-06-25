

func print(){
    print("Hello World!")
}
print()

var a = 10
print(a)

var b : String = "20"   
print(b)

let c : Int = 30;
print(c)

typealias newVariable = Int

var d :newVariable  = 40
print(d)

var tag = ("Name", "Cyan")
print(tag)

var (typed, userInput) = tag
print(typed)
print(userInput)
print("His name is \(userInput)")
print("His name is \(tag.1)")

var e : Int?
print(e)
e = 50
print(e)

var f : Int?
f = 55
if (f != nil) {
    print("the variable is not nil")    
}
else {
    print("the variable is nil")
}