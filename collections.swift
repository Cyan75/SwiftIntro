var arr1 : [Int] = [];
arr1.append(1);
arr1.append(1);
arr1.append(1);
print(arr1);

var arr2 = Array(repeating : 0.05, count : 3)
print(arr2);

var arr3 = Array(repeating : 0.25, count : 3)
var arr4 = arr2 + arr3
print(arr4)

var word:[String] = ["apple", "banana"]
print(word)

var apple = ["apple", ""]
print(apple)

print(arr4.count)

arr1 = []
print(arr1.isEmpty)

word.append("canada")
print(word)

word+=["dragon"]
print(word)

print(word[0])
print(word[2])

word.insert("orange", at: 1)
print(word)

word.remove(at:2)
print(word)

word.removeLast()
print(word)

word.insert("cookie", at:3)
word.insert("mirage", at:2)

for item in word{
    print(item)
}

for (index, value) in word.enumerated(){
    print("\(index+1): \(value)")
}
//---------------------

var colours = Set<String>()
print("letters is of type Set<Character> with \(colours.count) items.")