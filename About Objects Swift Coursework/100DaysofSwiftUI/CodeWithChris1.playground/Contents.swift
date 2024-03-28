import UIKit

123
0.7
"Hello"

var firstName = "Beatrice"
print(firstName)

let lastName = "Jones"

var stockPrice = 100
print(stockPrice)
stockPrice = 50
//print("Stock price changed to: " + (\stockPrice))

var str = "Hello, playground"

print(pow(2, 3))
print(sqrt(16))
print(ceil(4.5))
print(floor(4.5))

let a = 20
let b = 10

if a < 10 || b > 5 {
    print("a is less than 10 and b is greater than 5")
} else if a < 15 {
    print("a is greater than 15")
} else if a > 30 {
    print("a is greater than 30")
} else {
    print("a is something else")
}

let a1 = 25
let b1 = 10
let c1 = 1

if (a1 < 10 || b1 > 5) || c1 != 1 {
    print("branch 1")
} else if a1 < 15 {
    print("branch 2")
} else if a > 30 {
    print("branch 3")
} else {
    print("catch all")
}

let chr = "a"

switch chr {
case "a":
    print("this is an a")
case "b", "c":
    print("this is a b or c")
default:
    print("this is the fallback")
}

//using a _ here instead of a var name, a _ is a standin for a variable name
for _ in 1...5 {
    print("hello")
}

var sum = 0

for counter in 1...5 {
    sum += counter
}

print(sum)

var counter = 5

while counter > 0{
    print("hello")
    counter -= 1
}

var counter2 = -5

repeat {
    print("hello from repeat while loop")
    counter2 -= 1
} while counter2 > 0

func addTwo() {
    let a = 1
    let b = 2
    let c = a + b
    
    print(c)
}

addTwo()

func addTwoAndReturn(a: Int, b: Int) -> Int {
    let c = a + b
    
    return c
}

let summation = addTwoAndReturn(a: 2, b: 3)
print(summation)

class Person {
    var name = ""
    
    init() {
    }
    init(_ name: String) {
        self.name = name
    }
}

class Employee: Person {
    var salary = 0
    var role = ""
    
    func doWork() {
        print("Hi my name is \(name) and I'm doing work")
        salary += 1
    }
}

var emp = Employee()
emp.salary = 100000
emp.name = "Tom"
emp.role = "Director"

emp.doWork()

var emp2 = Employee()
emp2.name = "Sarah"
emp2.role = "Manager"
emp2.salary = 50000
emp2.doWork()

class Manager: Employee {
    var teamSize = 0
    //computed property, when its accessed it will run and return the value
    var bonus: Int {
        return teamSize * 1000
    }
    
    init(_ name: String, _ teamSize: Int) {
        super.init(name)
        
        self.teamSize = teamSize
    }
    
    override func doWork() {
        super.doWork()
        
        print("I'm managing people")
        salary += 2
    }
    
    func firePeople() {
        print("I'm firing people")
    }
}

var m = Manager("Maggie", 10)
m.role = "Manager of IT"
m.salary = 1000
m.doWork()
m.firePeople()
print(m.bonus)

let myPerson = Person()
print(myPerson.name)

//var n = nil
//var aN: Int = nil
var aNN: Int? = nil

class XmasPresent {
    func surprise() -> Int {
        return Int.random(in: 1...10)
    }
}

//bc we aren't using optional chaining, we have to unwrap it before it can run
var present1: XmasPresent? = nil
//it will crash since it tries to automatically unwrap it
var present2: XmasPresent! = nil

present2.surprise()

//Optional Binding
//if let actualPresent = present {
//    print(actualPresent.surprise())
//}

//Optional Chaining
//let present: XmasPresent? = XmasPresent()

