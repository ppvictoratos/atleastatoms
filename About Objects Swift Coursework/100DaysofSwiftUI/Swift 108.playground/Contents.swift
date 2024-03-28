//we can set parameters to have defaults
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.removeAll(keepingCapacity: true) //this keeps the array the same size as when it was initialized
print(characters.count)
characters.append("Lana")
print(characters.count)

func findDirections(from: String, to: String, route: String = "fastest", avoidHighways: Bool = false) {
    //code
}

findDirections(from: "DC", to: "NJ")
findDirections(from: "DC", to: "NJ", route: "scenic")
findDirections(from: "DC", to: "NJ", route: "scenic", avoidHighways: false)

//Handling errors: Let's check how strong a password is
enum PasswordError: Error {
    case short, obvious
}
//if a function is ABLE to throw an error without handling the error itself, mark "throws" before return type
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    
    if password == "12345" {
        throw PasswordError.obvious
    }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

//To handle errors

//1. Strating a block of work that might throw errors, use do

//2. Calling one of more throwing functions, using try

//3. Handling any thrown errors using catch

let string = "12345"

//try must be written before calling all functions that may throw errors
//it must be inside of a do block

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("Use a smarter password!")
} catch {
    print("There was an error.")
}

//not valid swift bc height isn't defined
//enum BuildingError: Error {
//    case tooHigh
//    case tooLow
//}
//func constructBuilding(floors: Int) throws {
//    if height < 10 {
//        throw BuildingError.tooLow
//    } else if height > 500 {
//        throw BuildingError.tooHigh
//    }
//    print("Perfect - let's get building!")
//}

//not valid swift bc error enum doesn't conform to error
//enum ChargeError {
//    case noCable
//    case noPower
//}
//func chargePhone(atHome: Bool) throws {
//    if atHome {
//        print("Phone is charging...")
//    } else {
//        throw ChargeError.noPower
//    }
//}

//checkpoint 4
//write a function that accepts an int 1 - 10_000 and returns int sq rt of that number
    //you must find sqrt yourself
    //if the number is less than 1 or greater than 10_000 you throw out of bounds error
    //only consider integer square roots
    //if there is no sq rt, throw no root error
enum RootError: Error {
    case noSquareRoot, outOfBounds
}

func integerSquareRoot(_ input: Int) throws -> Int {
    var root = 0
    if input >= 1 && input >= 10_000 {
        throw RootError.outOfBounds
    } else {
        for i in 1...10_000 {
            if i * i == input {
                root = i
                return root
            }
        }
    }
    if root == 0 {
        throw RootError.noSquareRoot
    }
}

do {
    let result = try integerSquareRoot(49)
    print("Square Root: \(result)")
} catch RootError.outOfBounds {
    print("Please enter a number between 1 & 10_000.")
} catch RootError.noSquareRoot {
    print("This number does not have a square root")
}

