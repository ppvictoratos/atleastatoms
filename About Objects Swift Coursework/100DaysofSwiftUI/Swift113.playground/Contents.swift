import Cocoa
import Darwin

//protocls allow us to define what kinds of functionality we expect a data type to support

struct Car {
    let numberOfWheels: Int = 4
    var isElectric: Bool = false
}

struct Train {
    var numberOfCars: Int = 8
}

func OLDcommute(distance: Int, using vehicle: Car) {
    
}


//func commute(distance: Int, using vehicle: Train) { }
//We could define a whole set of ways that a person can commute, but what we really care about is
    //how long this commute will take
//So we can create a Vehicle property

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

//Now we can design types that work with this protocol!
struct Peugot: Vehicle {
    var name: String
    
    var currentPassengers: Int
    
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Peugot(name: "208", currentPassengers: 2)
commute(distance: 100, using: car)

//since Swift knows that conforming to Vehicle must implement the estimateTime() and travel()
    //methods, we can use Vehicle as the parameter above, instead of Peugot

struct Bicycle: Vehicle {
    var name: String
    
    var currentPassengers: Int
    
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

let bike = Bicycle(name: "Trek Marliner 7", currentPassengers: 1)
commute(distance: 50, using: bike)

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

//So, protocols let us create blueprints of how our types share functionality, then use those blueprints in our functions to let them work on a wider variety of data.

//opaque return types ->

//func getRandomNumber() -> Int {
//    Int.random(in: 1...6)
//}

func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

//func getRandomBool() -> Bool {
//    Bool.random()
//}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

//neither of the above functions can return Equatable alone
//they must return some equatable, once compiled, swift understands what it is trying to return
    //this is so that we can be flexible with what is returned, as long as it conforms to equatable

protocol View { }

var quote = " The trust is rarely pure and never simple "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

let shortTrimmed = quote.trimmed()

//We could've also done this (make a global function):
func trim(_ string: String) -> String {
    string.trimmingCharacters(in: .whitespacesAndNewlines)
}

let trimmed2 = trim(quote)

//However, with the extension:
    //When you type quote., Xcode brings up a list of methods on the string, including all the ones we add in extensions. This makes our extra functionality easy to find.
    //Writing global functions makes your code rather messy – they are hard to organize and hard to keep track of. On the other hand, extensions are naturally grouped by the data type they are extending.
    //Because your extension methods are a full part of the original type, they get full access to the type’s internal data. That means they can use properties and methods marked with private access control, for example.

//If we wanted to modify the string directly, we would do this in the extension:
//mutating func trim() {
//    self = self.trimmed()
//}
//quote.trim()

//if you’re returning a new value rather than changing it in place, you should use word endings like ed or ing, like reversed().

//You can also use extensions to add properties to types, but there is one rule: they must only be computed properties, not stored properties.

extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)

//So, if we wanted our Book struct to have the default memberwise initializer as well as our custom initializer, we’d place the custom one in an extension, like this:
struct Book {
    var title: String
    var pageCount: Int
    var readingHours: Int
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

//Extensions are also useful for organizing our own code, and although there are several ways of doing this I want to focus on two here: conformance grouping and purpose grouping.

//Conformance grouping means adding a protocol conformance to a type as an extension, adding all the required methods inside that extension.
//On the other hand, purpose grouping means creating extensions to do specific tasks, which makes it easier to work with large types.

extension String {
    var isLong: Bool {
        return count > 25
    }
} //is valid bc count is already apart of String

extension Collection { //since Array is a collection, we can extend on collection
    var isNotEmpty: Bool {
        isEmpty == false
    }
} //protocol oriented programming

let guests = ["Mario", "Luigi", "Peach"]

//if !guests.isEmpty {
//    print("Guest count: \(guests.count)")
//} this sucks

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

protocol Person {
    var name: String { get }
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

struct Employee: Person {
    let name: String
}

let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()

//Protocols are like contracts for code: we specify the functions and methods that we required, and conforming types must implement them.
//Opaque return types let us hide some information in our code. That might mean we want to retain flexibility to change in the future, but also means we don’t need to write out gigantic return types.
//Extensions let us add functionality to our own custom types, or to Swift’s built-in types. This might mean adding a method, but we can also add computed properties.
//Protocol extensions let us add functionality to many types all at once – we can add properties and methods to a protocol, and all conforming types get access to them.

protocol Building {
    var numberRooms: Int { get set }
    var cost: Int { get }
    var realEstateAgent: String { get }
    
    func salesSummary() -> String
}

struct House: Building {
    var numberRooms: Int = 5
    
    var cost: Int = 325_000
    
    var realEstateAgent: String = "Macdonald/Becker"
    
    func salesSummary() -> String {
        return "This house has \(numberRooms) rooms and costs $\(cost). Listed by \(realEstateAgent)."
    }
}

struct Office: Building {
    var numberRooms: Int = 50
    
    var cost: Int = 1_325_000
    
    var realEstateAgent: String = "Macdonald/Becker"
    
    func salesSummary() -> String {
        return "This office has \(numberRooms) rooms and costs $\(cost). Listed by \(realEstateAgent)."
    }
}
