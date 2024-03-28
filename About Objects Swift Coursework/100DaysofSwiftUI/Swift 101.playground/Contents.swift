import UIKit

var greeting = "Hello, playground"

//variable -> value can vary over time, as many times as you want

//var <- create a new variable
//greeting <- name of the new variable
//= <- assign something
//"Hello, playground" <- Initial value

var name = "Ted"
name = "Rebecca"
name = "Keeley"

let character = "Daphne"
//characters = "Eloise" <- will not work

//constant -> value that can never change
/// "let" comes from math, as in "let x = 13"

var playerName = "Roy"
print(playerName)

playerName = "Dunderboy"
print(playerName)

///playerName is written in camelCase, which is a swift convention

let actor = "Denzel"
let filename = "paris.jpg"
let result = "🪤 Trap lord"

let quote = "Then he tapped a sign saying \"Believe\" and walked away."

let movie = """
A day in the life of
an Apple engineer
"""

print(actor.count)
let nameLength = actor.count

print(nameLength)
print(result.uppercased())

print(movie.hasPrefix("A day"))
print(filename.hasSuffix(".jpg"))

/// "integer" is a Latin word meaning "whole"

let score = 10
let reallyBig = 10000000
let reallyBigUnderscore = 100_000_000 //also can be let reallyBigUnderscore = 1__0____0__00_000

let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2
print(score)

var counter = 10
counter = counter + 5
counter += 5
print(counter)

counter *= 2
print(counter)
counter -= 10
print(counter)
counter /= 2
print(counter)

let number = 120
print(number.isMultiple(of: 3))
print(120.isMultiple(of: 3))


let decimalNumber = 0.1 + 0.2
print(decimalNumber)

///double = "double-precision floating-point number"
///integers are 100% accurate, whereas demicals are not, so they cannot be combined

let a = 1
let b = 2.0
//let c = a + b
let c = a + Int(b) // or let c = Double(a) + b

let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let int1 = 3
