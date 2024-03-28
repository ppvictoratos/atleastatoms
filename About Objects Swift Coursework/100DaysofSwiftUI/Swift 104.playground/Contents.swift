//type inference: where Swift infers the data type based upon the assigned value
let surname = "Lasso"
var score = 0

//type annotation: explicit data type usage
let lastName: String = "Lasso"
var gameScore: Int = 0

//String holds text:
let playerName: String = "Roy"

//Int holds whole numbers:
var luckyNumber: Int = 13

//Double holds decimal numbers:
let pi: Double = 3.141

//Bool holds true or false:
var isAuthenticated: Bool = true

//Array holds lots of different values, all in the order you add them
var albums: [String] = ["Red", "Fearless"]

//Dictionary holds a lot of different values, where you get to decide how data should be accessed
var user: [String: String] = ["id": "@shneakypete"]

//Set holds lots of different values, but stores them in an order that optimzed for checking what it contains
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, Other"])

//Type annotation isn't needed here because Swift can see you're assigning an array of strings
var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"]

//If you want to create an empty array of strings, you need to know the type:
var teams: [String] = [String]()
//some people prefer type annotation to create an empty array:
var cities: [String] = []

//Paul prefers to use type inference:
var clues = [String]()
//bc it makes code shorter and easier to read
//it allows him to change the type of somethign just by changing whatever is its intial value

//Enums allow us to create types of our own
enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light
style = .dark

//Using type annotations in this instance, where we don't have the value yet, is fair game
let username: String
//blah
username = "@Pete"
//blah
print(username)

//SWIFT MUST AT ALL TIMES KNOW WHAT DATA TYPES YOUR CONSTANTS/VARIABLES CONTAIN

//Swift has type annotations bc maybe:
//Swift can't figure out what type should be used
//You want Swift to use a different type from the default
//You don't want to assign a value just yet

//Checkpoint 2: Create an array of strings then write code that prints the number of items in the array and also the unique items in the array

var strings = [String]()
strings.append("Balls")
strings.append("Balls")
strings.append("Weiners")
strings.append("Weiners")
strings.append("Breasts")
strings.append("Butts")

var stringsSet: Set<String> = Set(strings)
print("Count of items in the array: \(strings.count)")
print("Count of unique items in the array: \(stringsSet.count)")
