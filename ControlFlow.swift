let snacks = ["oreo","biscoff","sand","cookie"]
for snack in snacks{
    print("\(snack)");
}

let ages = ["Lili":15, "Zari":15, "Eddy":35, "Bea":25,"Junior":8, "Oscar":39]
for (name,age) in ages{
    print ("\(name) : \(age)")
}
//no specific order

for index in 1...5{
    print (index)
}

let greet =  "hello"
for _ in 1...3{
    print(greet);   
}

for a in stride(from : 0, to : 10, by: 1)
//for(int = 0 ; i < 10 ; i++ )
