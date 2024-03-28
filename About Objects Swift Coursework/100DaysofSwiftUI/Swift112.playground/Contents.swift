import Cocoa

//  Similarities between Structs & Classes
//You can create and name classes
//You can add properties, methods, property observers, and accses control
//You can create custom initializers to configure new instances however you want

//  Difference of Classes
//You can make one class build upon functionality in another class
//Swift won't generate a memberwise initializer for classes
//If you copy an instance of a class, both copies share the same data *big in SwiftUI
//We can add a deinit to run when the final copy is destroyed
//Constant class instances can have their vairable properties changed

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

//final means that nothing can inherit from this, is kind of a good default tbh
//override lets you change an inherited function
    
final class Developer: Employee {
    func work() {
        print("Im writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times will spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

final class Manager: Employee {
    func work() {
        print("Im in meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 8)
novall.printSummary()

//if a child class has any custom initializers, it must always call the parent's initializer after it has finished setting up its own properties, if it has any


class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible //leaving it here, super.init isn't called on all paths
        super.init(isElectric: isElectric)
    }
}

//if a class doesn't have custom initializers, it will inherit super class initializers
class Car2: Vehicle {
    let isConveritble = false
}

let teslaX = Car(isElectric: true, isConvertible: false)

class User {
    var username = "Anon"
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"

print(user1.username)
print(user2.username)

//if we want to create a unique copy - a deep copy - you must create a new instance and copy

class CopyUser {
    var username = "Anonymouse"
    
    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

//Just like initializers, you don’t use func with deinitializers – they are special.
//Deinitializers can never take parameters or return data, and as a result aren’t even written with parentheses.
//Your deinitializer will automatically be called when the final copy of a class instance is destroyed. That might mean it was created inside a function that is now finishing, for example.
//We never call deinitializers directly; they are handled automatically by the system.
//Structs don’t have deinitializers, because you can’t copy them.

class DeUser {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    let user = DeUser(id: i)
    print("User \(user.id): I'm in control!")
}

var users = [DeUser]()

for i in 1...3 {
    let user = DeUser(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")

class Light {
    var onState = false
    func toggle() {
        if onState {
            onState = false
        } else {
            onState = true
        }
        print("Click")
    }
}
let light = Light()
light.toggle()

//Classes have lots of things in common with structs, including the ability to have properties and methods, but there are five key differences between classes and structs.
//First, classes can inherit from other classes, which means they get access to the properties and methods of their parent class. You can optionally override methods in child classes if you want, or mark a class as being final to stop others subclassing it.
//Second, Swift doesn’t generate a memberwise initializer for classes, so you need to do it yourself. If a subclass has its own initializer, it must always call the parent class’s initializer at some point.
//Third, if you create a class instance then take copies of it, all those copies point back to the same instance. This means changing some data in one of the copies changes them all.
//Fourth, classes can have deinitializers that run when the last copy of one instance is destroyed.
//Finally, variable properties inside class instances can be changed regardless of whether the instance itself was created as variable.

class Animal {
    var legs = 2
    var sound = "Noise"
    
    func speak() {
        print(self.sound)
    }
}

class Dog: Animal {
    override func speak() {
        
    }
}

class Corgi: Dog {
    
}

class Poodle: Dog {
    
}

class Cat: Animal {
    var isTame = false
    
    override func speak() {
        
    }
    
}

class Persian: Cat {
    
}

class Lion: Cat {
    
}
