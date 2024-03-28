

struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()

struct Employee {
    let name: String
    var vacationRemaining: Int

    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)
//however if you make this "var" a "let" you won't be able to call takeVacation

//Variables and constants that belong to structs are called properties
//Functions that belong to structs are called methods
//When we create a constant/variable out of a struct, its an instance
//When we create an instance of a struct, we do so using an initializer
//Syntactic Sugar is where Swift silently creates a special function inside the struct called init()
var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)

//So, use tuples when you want to return two or more arbitrary pieces of values from a function, but prefer structs when you have some fixed data you want to send or receive multiple times.

//Marking methods as mutating will stop the method from being called on constant structs, even if the method itself doesn’t actually change any properties. If you say it changes stuff, Swift believes you!
//A method that is not marked as mutating cannot call a mutating function – you must mark them both as mutating.

struct Surgeon {
    var operationsPerformed = 0
    mutating func operate(on patient: String) {
        print("Nurse, hand me the scalpel!")
        operationsPerformed += 1
    }
} //is true

//struct Stapler {
//    var stapleCount: Int
//    func staple() {
//        if stapleCount > 0 {
//            stapleCount -= 1
//            print("It's stapled!")
//        } else {
//            print("Please refill me.")
//        }
//    }
//} mutates stapleCount, so its false

//a stored property is a variable or constant that holds a piece of data inside an instance of a struct
//a computed property calculates the value of the property dynamically every time it's accessed

struct ComputedEmployee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }

        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archerie = ComputedEmployee(name: "Sterling Archer", vacationAllocated: 14)
archerie.vacationTaken += 4
print(archerie.vacationRemaining)
archerie.vacationTaken += 4
print(archerie.vacationRemaining)

//struct Candle {
//    var burnLength: Int
//    var alreadyBurned = 0
//    let burnRemaining: Int {
//        return burnLength - alreadyBurned
//    }
//} this doesn't work bc constants cannot be computed properties

//struct Dog {
//    var breed: String
//    var cuteness: Int
//    var rating: String {
//        if cuteness < 3 {
//            print("That's a cute dog!")
//        } else if cuteness < 7 {
//            print("That's a really cute dog!")
//        } else {
//            print("That a super cute dog!")
//        }
//    }
//}
//let luna = Dog(breed: "Samoyed", cuteness: 11)
//print(luna.rating) this should return strings, not print them

struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)") //whenever score changes, it prints
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

struct Player {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    } //adding this allows us to customize Player
        //init is not a func
        //init doesn't return something else, just a player
        //self -> "assign the name parameter to my name property"
}

let player = Player(name: "Megan R") //memberwise initializer
print(player.number)
