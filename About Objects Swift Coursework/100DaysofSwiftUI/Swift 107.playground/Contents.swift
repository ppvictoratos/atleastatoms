import Foundation

func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

//() are known as the function's call site
    //call site: a place where a function is called
showWelcome()

let number = 139

if number.isMultiple(of: 2) {
    print("Even")
} else {
    print("Odd")
}

func printTimesTable(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTable(number: 5)

//the int is the parameter, Swift makes it so that you name the paramter in a function call:
func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 20)
//number / end are PARAMETERS = placeholder
//5 / 20 are ARGUMENTS = actual value

//You want to create your own function when:
    //1. If you want the same functionality in many places
    //2. To break up your code
    //3. Function composition

// Code Smell = somethign about your code suggests that there is an underlyring problem in the way it is structured

func square(numbers: [Int]) {
    for number in numbers {
        let squared = number * number
        print("\(number) squared is \(squared).")
    }
}
square(numbers: [2, 3, 4])

//not valid swift bc the switch isn't exhaustive
//func buyCar(price: Int) {
//    switch price {
//    case 0...20_000:
//        print("This seems cheap.")
//    case 20_001...50_000:
//        print("This seems like a reasonable car.")
//    case 50_001...100_000:
//        print("This had better be a good car.")
//    }
//}

func rollDice() -> Int {
    Int.random(in: 1...6)
}

let result = rollDice()
print(result)

//since this has one line of code in the brackets, we can remove the return
func areLettersIdentical(string1: String, string2: String) -> Bool {
    //return
    string1.sorted() == string2.sorted()
}

func pythagoras(a: Double, b: Double) -> Double {
    let input = a * a + b * b
    let root = sqrt(input)
    return root
}

let c = pythagoras(a: 3, b: 4)
print(c)

func pythagorasOneLiner(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

func greet(name: String) -> String {
    name == "TSwift" ? "Oh wow!" : "Hello, \(name)"
}

greet(name: "TSwift")

//this is not valid bc we aren't guaranteed to reach the boolean
//func paintHouse(color: String) -> Bool {
//    if color == "tartan" {
//        return false
//    }
//}

func getUser() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift")
}

let user = getUser()
print("Name: \(user.0) \(user.1)")

let (firstName, lastName) = getUser()
print("Name: \(firstName) \(lastName)")

func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let resulty = isUppercase(string)

//not valid
//func printLogMessage(message: String) -> Bool {
//    print("Log: \(message)")
//    return true
//}
//printLogMessage("Something went wrong!")

func greet(_ name: String) {
    print("Hi, \(name)!")
}
greet(name: "Han")
greet("Han")
