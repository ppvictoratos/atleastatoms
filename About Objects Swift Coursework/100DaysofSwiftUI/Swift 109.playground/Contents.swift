func greetUser() {
    print("Hi there!")
}

let sayHello = {
    print("Hi there!")
}

sayHello()

let sayGoodbye = {
    (name: String) -> String in
    "Bye, \(name)!"
}

print(sayGoodbye("Felicia"))

var greetCopy: () -> Void = greetUser

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

//let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
//    if name1 == "Suzanne" {
//        return true
//    } else if name2 == "Suzanne" {
//        return false
//    }
//
//    return name1 < name2
//})

//1. We’re calling the sorted() function as before.
//2. Rather than passing in a function, we’re passing a closure – everything from the opening brace after by: down to the closing brace on the last line is part of the closure.
//3. Directly inside the closure we list the two parameters sorted() will pass us, which are two strings. We also say that our closure will return a Boolean, then mark the start of the closure’s code by using in.
//4. Everything else is just normal function code.

let captainFirstTeam = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    
    return $0 < $1
}
print(captainFirstTeam)

let reverseTeam = team.sorted { $0 > $1 }

// if a closure body is long
// if $x is used multiple times
// if you have more than 3 $x...
// probably shouldn't use $x syntax

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

greetCopy()

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    
    return numbers
}

let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)

func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("ABout to start second work")
    second()
    print("About to start third work")
    third()
    print("done!")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}

//let resignation = { (name: String) in
//    print("Dear \(name), I'm outta here!")
//}
//func printDocument(contents: () -> Void) {
//    print("Connecting to printer...")
//    print("Sending document...")
//    contents()
//}
//printDocument(contents: resignation) IS NOT VALID BC printDoc take a var

//func holdClass(name: String, lesson: () -> Void) {
//    print("Welcome to \(name)!")
//    lesson()
//    print("Make sure your homework is done by next week.")
//}
//holdClass("Philosophy 101", lesson:) {
//    print("All we are is dust in the wind, dude.")
//} WE SHOULDNT HAVE THE "lesson:" AT THE END

//Summary:

//You can copy functions in Swift.
//You can create closures directly by assigning to a constant/variable
//Closure parameters and return value are declared inside their braces
//Functions are able to accept other functions as parameters
//Anywehre you can pass a function, you can also pass a closure
//When passing a closure as a function paramters, you don't need to write the types out
//If a function's final parameters is a function, use trailing closure syntax
//Shorthand parameters = $0 & $1
//You can make functions that accept functions as parameters

var luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

func doSomethingToLuckyNumbers(filter: () -> Void, sort: () -> Void, map: () -> Void) {
    print("About to start filtering")
    filter()
    print("ABout to start sorting")
    sort()
    print("About to start mapping")
    map()
    print("done!")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}

doSomethingToLuckyNumbers {
    luckyNumbers.filter { $0.isMultiple(of: 2) }
    print("No more evens")
}   sort: {
    luckyNumbers.sorted()
    print("Sorted ascending")
}   map: {
    luckyNumbers.map { String($0) + "is a lucky number"}
    print(luckyNumbers)
}
