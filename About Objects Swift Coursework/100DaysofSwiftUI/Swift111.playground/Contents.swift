import Cocoa

var greeting = "Hello, playground"

struct BankAccount {
    //var funds = 0
    private var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

//account.funds -= 1000 can occur bc its exposed

//Swift provides us with several options, but when you’re learning you’ll only need a handful:
//
//Use private for “don’t let anything outside the struct use this.”
//Use fileprivate for “don’t let anything outside the current file use this.”
//Use public for “let anyone, anywhere use this.”
//
//There’s one extra option that is sometimes useful for learners, which is this: private(set). This means “let anyone read this property, but only let my methods write it.” If we had used that with BankAccount, it would mean we could print account.funds outside of the struct, but only deposit() and withdraw() could actually change the value.

//struct FacebookUser {
//    private var privatePosts: [String]
//    public var publicPosts: [String]
//}
//let user = FacebookUser() won't work

struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount) //the static keywords mean that these properties are made for all schools, not each school

//If you want to mix and match static and non-static properties and methods, there are two rules:
//
//To access non-static code from static code… you’re out of luck: static properties and methods can’t refer to non-static properties and methods because it just doesn’t make sense – which instance of School would you be referring to?
//To access static code from non-static code, always use your type’s name such as School.studentCount. You can also use Self to refer to the current type.

//Now we have self and Self, and they mean different things:
//self refers to the current value of the struct, and Self refers to the current type.

//First, I use static properties to organize common data in my apps.
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

//The second reason I commonly use static data is to create examples of my structs.
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

//Let’s recap what else we learned:
//
//You can create your own structs by writing struct, giving it a name, then placing the struct’s code inside braces.
//Structs can have variable and constants (known as properties) and functions (known as methods)
//If a method tries to modify properties of its struct, you must mark it as mutating.
//You can store properties in memory, or create computed properties that calculate a value every time they are accessed.
//We can attach didSet and willSet property observers to properties inside a struct, which is helpful when we need to be sure that some code is always executed when the property changes.
//Initializers are a bit like specialized functions, and Swift generates one for all structs using their property names.
//You can create your own custom initializers if you want, but you must always make sure all properties in your struct have a value by the time the initializer finishes, and before you call any other methods.
//We can use access to mark any properties and methods as being available or unavailable externally, as needed.
//It’s possible to attach a property or methods directly to a struct, so you can use them without creating an instance of the struct.

//To check your knowledge, here’s a small task for you:
    //create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down. Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?

struct Car {
    let modelNumber: Int
    let seatsInCar: Int
    private var currentGear: Int
    init(modelNumber: Int, seatsInCar: Int) {
        self.modelNumber = modelNumber
        self.seatsInCar = seatsInCar
        self.currentGear = 2
    }
    
    //given that up = true & down = false
    mutating func changeGear(upOrDown: Bool) {
        if upOrDown {
            currentGear += 1
        } else {
            currentGear -= 1
        }
    }
    
    mutating func gearChange(gear: Int) -> Bool {
        if gear > 0 && gear < 10 {
            currentGear = gear
            return true
        } else {
            return false
        }
    }
}
var car = Car(modelNumber: 12345, seatsInCar: 5)
car.changeGear(upOrDown: true)
