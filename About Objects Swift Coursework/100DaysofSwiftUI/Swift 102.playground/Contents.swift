let filename = "paris.jpg"
print(filename.hasSuffix(".jpg"))

let number = 120
print(number.isMultiple(of: 3))

let goodDogs = true
let gameOverConst = false

let isMultiple = 120.isMultiple(of: 3)

var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated)
isAuthenticated = !isAuthenticated
print(isAuthenticated)

var gameOver = false
print(gameOver)

gameOver.toggle()
print(gameOver)

//String Interpoliation is what allows you to play variables of any type directly inside strings

let firstPart = "Hello, "
let secondPart = "world!"
let greeting = firstPart + secondPart

let people = "Haters"
let action = "hate"
let lyric = people + " gonna" + action
print(lyric)

// operator overloading - the ability for one operator such as + to mean different things depending on how it's used

let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old."
print(message)

let missionNumber = 11
//let missionMessage = "Apollo " + number + " landed on the moon."
//let missionMessage = "Apollo " + String(number) + " landed on the moon."
let missionMessage = "Apollo \(missionNumber) landed on the moon."

print("5 x 5 is \(5 * 5)")
print("\n")

/// MARK: Checkpoint 1

// Create a constant holding any temperature in Celsius
let celsiusTemperature = 40
// Convert that temperature to Fahrenheit by multiplying by 9, dividing by 5, then adding 32
var fahrenheitTemperature = ((celsiusTemperature * 9) / 5) + 32
// Print the result for the user, showing both the Celsuis and Fahrenheit values.
print("""
Celsius temperature is \(celsiusTemperature)ºC \n
Fahrenheit temperature is \(fahrenheitTemperature)ºF \n
""")
