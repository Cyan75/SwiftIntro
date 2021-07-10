

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
//type alias
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

//optional forced unwrapping
var e : Int?
print("e = \(e)")
e = 50
print("e = \(e)")
print("e! = \(e!)")

//Optional Binding
var f : Int?
f = 55
if (f != nil) {
    print("f = \(f)")    
}
else {
    print("f = \(f)")
}
//implicitly unwrapping
var h: Int!
h = 60
let i = h
print("i = \(i)")


var j : [Int] = []
j.append(1)
j.append(3)
j.append(5)
j.append(7)
print(j)
for j_i in j{
 print (j_i)
}
