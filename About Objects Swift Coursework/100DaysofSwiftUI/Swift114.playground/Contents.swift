import Cocoa

let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"]

if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

//if let syntax does three things:
    //It reads the optional value from the dictionary.
    //If the optional has a string inside, it gets unwrapped - that means the string inside gets placed into the marioOpposite constant
    //The condition has succeeded - we were able to unwrap the optional - so the condition's body is run

var username: String? = nil

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}

//Swift didn't introduce optionals. It introduced non-optionals.

func square(number: Int) -> Int {
    number * number
}

var number: Int?  = nil
//print(square(number: number)) //value of optional type 'Int?' must be unwrapped

if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
}
//or we can:
if let number = number { print(square(number: number)) }

//Any data type can be optional in Swift

func getUsername() -> String? { "Taylor" }

if let username = getUsername() {
    print("Username is \(username)")
} else {
    print("No username")
}

//guard let does the same thing as if let to unwrap optionals

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }
    
    print("\(number) x \(number) is \(number * number)")
}

var myVar: Int? = 3

//if let unwrapped = myVar { run if myvar has a value }

//guard let unwrapped = myVar else { run if myVar doesn't have a value }

//guard provides the ability to check whether our program state is what we expect (early return)
    //1. if you use guard to check a function's inputs are valid, Swift will always require you to use return if the check fails
    //2. If the check passes and the optional you're unwrapping has a value inside, you can use it after the guard code finishes

//swift requires you to use return if a guard check fails
//if the optional has a value, you can use it after the guard code finishes

//you can guard with any condition, including ones that don't unwrap optionals
    //guard someArray.isEmpty else { return }

//there is a third way of unwrapping optionals: nil coalescing operator
let captains = [ "Enterprise": "Picard",
                 "Voyager": "Janeway",
                 "Defiant": "Sisko"]

let new = captains["Serenity"]
//since there isn't a matching value, it gets set to nil.. unless
let new2 = captains["Serenity"] ?? "N/A"
//or
let new3 = captains["Serenity", default: "N/A"]

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "Beowulf", author: nil)
let author = book.author ?? "Anonymous"
print(author)

let input = ""
let num = Int(input) ?? 0
print(num)

func first() -> String? {
    return "Balls"
}

func second() -> String? {
    return "2 Balls"
}
//you can chain nil coalescing
let savedData = first() ?? second() ?? ""
//reading a dictionary key will always return an optional
let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore = scores["Crusher"] ?? 0

//var conferenceName: String? = "WWDC"
//var conference: String = conferenceName ?? nil THIS WON'T WORK

let namesGOT = ["Arya", "Bran", "Robb", "Sansa"]
let chosen = namesGOT.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")
//if the optional has a value, unwrap it then

struct Book2 {
    let title: String
    let author: String?
}

var book2: Book2? = nil
let author2 = book2?.author?.first?.uppercased() ?? "A"
print(author2)

func albumReleased(in year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    case 2017: return "Reputation"
    default: return nil
    }
}
let album = albumReleased(in: 2006)?.uppercased()

//whether the function works or not, use optional try

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

let userB = (try? getUser(id: 23)) ?? "Anon"
print(userB)

//try? is mainly used in three places:
    //1. In combination with guard let to exit the current function if the try? call returns nil
    //2. In combination with nil coalesing to attempt something or probide a deafult value on failure
    //3. When calling any throwing function without a return value, when you genuinely don't care if it
        //succeeded or not - maybe you're writing to a log file or sending analytics to a server

//Optionals let us represent the absence of data, which means we’re able to say “this integer has no value” – that’s different from a fixed number such as 0.
//As a result, everything that isn’t optional definitely has a value inside, even if that’s just an empty string.
//Unwrapping an optional is the process of looking inside a box to see what it contains: if there’s a value inside it’s sent back for use, otherwise there will be nil inside.
//We can use if let to run some code if the optional has a value, or guard let to run some code if the optional doesn’t have a value – but with guard we must always exit the function afterwards.
//The nil coalescing operator, ??, unwraps and returns an optional’s value, or uses a default value instead.
//Optional chaining lets us read an optional inside another optional with a convenient syntax.
//If a function might throw errors, you can convert it into an optional using try? – you’ll either get back the function’s return value, or nil if an error is thrown.

func opInt(optionalArray: [Int]?) -> Int { return optionalArray?.randomElement() ?? Int.random(in: 1...100)}
opInt(optionalArray: nil)
opInt(optionalArray: [5,5,77])
