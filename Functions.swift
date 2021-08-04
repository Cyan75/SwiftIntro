func greet(name : String) -> String{
    let greet = "hi " + name + " !"
    return greet
}
print( greet(name : "Cyan"))

//no parameter
func sayHello() -> String{
    return "hello, world!";
}
print(sayHello())

//one parameter, one return type
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))

//two return types
func greet(person : String, alreadyGreeted : Bool) -> String {
    if alreadyGreeted{
        return greetAgain(person : person);
    }
    else{
        return greet(name : person);
    }
}
print(greet(person: "Tim", alreadyGreeted : false));

//no return type
func greet(person:String){
    print("hello, \(person)!")
}
greet(person : "Dave")


//returning tuple
func minMax(array : [Int]) -> (min: Int, max : Int){
    var currentMin = array[0];
    var currentMax = array[0];
    for value in array[1..<array.count]{
        if(value < currentMin){
            currentMin = value;
        }
        else if(value > currentMax){
            currentMax = value;
        }
    }
    return(currentMin, currentMax);
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

// func minMax(array: [Int]) -> (min: Int, max: Int)? {
//     if array.isEmpty { return nil }
//     var currentMin = array[0]
//     var currentMax = array[0]
//     for value in array[1..<array.count] {
//         if value < currentMin {
//             currentMin = value
//         } else if value > currentMax {
//             currentMax = value
//         }
//     }
//     return (currentMin, currentMax)
// }


let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)