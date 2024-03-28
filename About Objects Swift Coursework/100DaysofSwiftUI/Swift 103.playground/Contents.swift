var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 15, 16, 23, 42]
var temperatures = [25.3, 28.3, 26.4]

///index is the position of an item in an array

print(beatles[0])
print(numbers[1])
print(temperatures[2])

///if you index an item that doesn't exist, the code will crash

beatles.append("Adrian")

beatles.append("Allen")
beatles.append("Adrian")
beatles.append("Novall")
beatles.append("Vivian")

//temperature.append("Chris) isn't allowed
let firstBeatle = beatles[0]
let firstNumber = numbers[0]
//let notAllowed = firstBeatle + firstNumber

var scores = Array<Int>() //an array that holds integers
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

//var albums = Array<String>() <- an array that holds strings
var albums = [String]()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

print(albums.count)
print("\n")

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)

characters.removeAll()
print(characters.count)

let bondMovies = ["Casino Royale", "Spectre", "No Time To Die"]
print(bondMovies.contains("Frozen"))

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())

let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents) //Swift remembers to itself that you want it reversed, it doesn't actually reverse it

///Swift arrays are "zero-based" meaning it counts from 0

var employee = ["Taylor Swift", "Singer", "Nashville"]
print("Name: \(employee[0])")
print("Name: \(employee[1])")
print("Name: \(employee[2])")

print("Name: \(employee[0])")
employee.remove(at: 1)
print("Name: \(employee[1])")
//print("Name: \(employee[2])") causes an EXC_BREAKPOINT

let employee2 = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

print(employee2["name"])
print(employee2["job"])
print(employee2["location"])

print(employee2["password"])
print(employee2["status"])
print(employee2["manager"])

print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])

let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false,
]

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]

print(olympics[2012, default: "Unknown"])

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206

var archEnemies = [String: String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"
archEnemies["Batman"] = "Penguin"

////incorrect:
//let albums = ["Prince": "Purple Rain"]
//let beatles = albums["Beatles"]

let peopleConst = Set(["Denzel", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
print(peopleConst)

var people = Set<String>()
people.insert("Denzel Washington")
people.insert("Tom Cruise")
people.insert("Nicolas Cage")
people.insert("Samuel L Jackson")
print(people)

//Sets will store items in whatever order it wants

//Sets are unordered and CANNOT contain duplicates
    //“An unordered collection of unique elements.”
    //.insert(_:)
    //elements muct conform to Hashable
    //use if performance is important
//Arrays retrain order and CAN contain duplicates
    //“An ordered, random-access collection.”
    //.append(_:)
    //use if performance isn't important

//Not a set-> let earthquakeStrengths = Set(1, 1, 2, 2)

//Array use append(_:)
var array = ["One", "Two", "Three"]
array.append("Four")

var set = Set<String>()
set.insert("To")
set.insert("Two")
set.insert("Too")

//insert method returns a "inserted" bool & "memberAfterInsert" property
//this property contains the already-existing object or the just-inserted object

let (inserted, memberAfterInsert) = set.insert("Too")
if !inserted {
    print("\(memberAfterInsert) already exists")
}
// Prints: "Swift already exists"

//enum is short for enumeration, it is a set of named values
var selected = "Monday"
selected = "Tuesday"
selected = "January" //<- not ideal
selected = "Friday " //<- not ideal

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

//or enum Weekday { case monday, tuesday, wednesday, thursday, friday }

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

