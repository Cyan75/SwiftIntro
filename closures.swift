
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)



let ranNum = [75,10,21,11,7,1,33];
var ordNum = ranNum.sorted()
print("ranNum : \(ranNum)")
print("ordNum : \(ordNum)")
print("descending order : \(ranNum.sorted(by : descending))")

func descending(_ x : Int, _ y : Int) -> Bool{
    return x > y;   
}


