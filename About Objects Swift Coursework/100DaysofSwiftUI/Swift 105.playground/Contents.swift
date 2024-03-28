import SwiftUI
import PlaygroundSupport

if 80 < 100 {
    print("Do something")
    print("Do something else")
}

let score = 85

if score < 80 {
    print("Great job!")
}

let speed = 88
let percentage = 85
let age = 18

if speed >= 88 {
    print("Where we're going we don't need roads.")
}

if percentage < 85 {
    print("Sorry, you failed the test.")
}

if age >= 18 {
    print("You're eligible to vote")
}

let ourName = "Dave Lister"
let friendName = "Arnold Rimmer"

if ourName < friendName {
    print("It's \(ourName) vs \(friendName)")
}

if ourName > friendName {
    print("It's \(friendName) vs \(ourName)")
}

// Make an array of 3 numbers
var numbers = [1, 2, 3]

// Add a 4th
numbers.append(4)

// If we have over 3 items
if numbers.count > 3 {
    // Remove the oldest number
    numbers.remove(at: 0)
}

// Display the result
print(numbers)

let country = "Canada"

if country == "Australia" {
    print("G'day!")
}

let name = "Taylor Swift"

if name != "Anonymous" {
    print("Welcome, \(name)")
}

// Create the username variable
var username = "taylorswift13"

// If `username` contains an empty string
if username == "" {
    // Make it equal to "Anonymous"
    username = "Anonymous"
}

// Now print a welcome message
print("Welcome, \(username)!")

if username.count == 0 {
    username = "Anonymous"
}

//since Swift counts each part of a string, it added .isEmpty to guard
if username.isEmpty == true {
    username = "Anonymous"
}

//.isEmpty is already a boolean!
if username.isEmpty {
    username = "Anonymous"
}

enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second)

//else let's us avoid unecessary code
let agePerson = 16

if agePerson >= 18 {
    print("You can vote in the next election.")
} else {
    print("Sorry, you're too young to vote.")
}

//you can only ever have one else, because htat means "if all the other conditions have been false"
//but you can have multiple else ifs
let a = false
let b = true

if a {
    print("Code to run if a is true")
} else if b {
    print("Code to run if a is false but b is true")
} else {
    print("Code to run if both a and b are false")
}

//“if today’s temperature is over 20 degrees Celsius but under 30, print a message.”
let temp = 25

if temp > 20 {
    if temp < 30 {
        print("It's a nice day.")
    }
}
//or
if temp > 20 && temp < 30 {
    print("It's a nice day.")
}

//opposite of && is ||
let userAge = 14
let hasParentalConsent = true

if userAge >= 18 || hasParentalConsent == true {
    print("You can buy the game")
}
//or
if userAge >= 18 || hasParentalConsent {
    print("You can buy the game")
}

enum TransportOption {
    case airplane, helicopter, bicycle, car, scooter
}

//now that we've declared the enum, we don't need to invlude it anymore
let transport = TransportOption.airplane

if transport == .airplane || transport == .helicopter {
    print("Let's fly!")
} else if transport == .bicycle {
    print("I hope there's a bike path…")
} else if transport == .car {
    print("Time to get stuck in traffic.")
} else {
    print("I'm going to hire a scooter now!")
}

let joeCool: UIImage = UIImage(named: "joeCoolMeme.jpeg")!

struct ContentView: View {
    var body: some View {
        Image(uiImage: joeCool)
    }
}

PlaygroundPage.current.setLiveView(ContentView())

//allows for one check
if score > 9000 {
    print("It's over 9000!")
} else if score == 9000 {
    print("It's exactly 9000!")
} else {
    print("It's not over 9000!")
}

//var actualWage: Int = 22_000
//var medianWage: Double = 22_000
//if actualWage >= medianWage {
//    print("Success")
} //this will not print success since these data types cannot be compared

//Swift checks its cases in order and runs the first one that matches.
let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman!")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther!")
default:
    print("Who are you?")
}

//Second, if you explicitly want Swift to carry on executing subsequent cases, use fallthrough. This is not commonly used, but sometimes – just sometimes – it can help you avoid repeating work.

let day = 5
print("My true love gave to me…")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

//Switch > if

//1. Swift requires that its switch statements are exhaustive, which means you must either have a case block for every possible value to check (e.g. all cases of an enum) or you must have a default case. This isn’t true for if and else if, so you might accidentally miss a case.
//2. When you use switch to check a value for multiple possible results, that value will only be read once, whereas if you use if it will be read multiple times. This becomes more important when you start using function calls, because some of these can be slow.
//3. Swift’s switch cases allow for advanced pattern matching that is unwieldy with if.

let canVote = age >= 18 ? "Yes" : "No"
//WTF
//What? True? False.

//What is our condition? Well, it’s age >= 18.
//What to do when the condition is true? Send back “Yes”, so it can be stored in canVote.
//And if the condition is false? Send back “No”.

let phone = "iPhone"
print(phone == "Android" ? "Failure" : "Success")
//will print Success


