/*:
 * Callout(Problem): In the card game Uno, every card is either blue, green, red, yellow, or a wild card.  Create an `UnoColor` enumeration to model this feature of the game.
 */

// your code here

enum UnoColor {
    case blue
    case green
    case red
    case yellow
    case wild
}

/*:
 * Callout(Problem): Create a variable representing a blue card.  Print it out.  Change it to a wild card.  Print it out.
 */

// your code here
var card1 = UnoColor.blue
print(card1)
card1 = .wild
print(card1)


/*:
 * Callout(Problem): Implement a method below that takes an `UnoColor` as input and prints a heart emoji that matches the card color (use a black heart for the wild card).  Do not use if statements.  You can use control-command-space to bring up an emoji picker, or just grab them from here: ❤️💛💚💙🖤
 
 */

// your code here
func unoEmoji(_ color: UnoColor){
    switch color{
    case .blue:
        print("💙")
    case .green:
        print("💚")
    case .red:
        print("❤️")
    case .yellow:
        print("💛")
    case .wild:
        print("🖤")
    }
}

/*:
 * Callout(Problem): Uncomment the method below and finish the implementation to return whether the color of the played card is either the same color as the top card or is wild.  Call the method with a variety of values to confirm that the implementation is correct.
 */

func allowedToPlay(color: UnoColor, on top: UnoColor) -> Bool {
    if color == top {
        return true
    }
    else {
        return false
    }
}

allowedToPlay(color: .red, on: .blue)
allowedToPlay(color: .red, on: .red)
allowedToPlay(color: .wild, on: .wild)

/*:
 * Callout(Problem):
   - Update the `total` method implementation below (and from the previous problem set) to accept an array of optional integer values.
     - Ignore any `nil` values in calculating the sum.
     - If the input array is empty, return 0.
     - If the input array consists only of `nil` values, return 0.
   - Update the test of the `total` method by adding three additional calls using inputs that cover the cases described above.
   - Execute the code and check that the results match your expectations.
 */

func total(_ values: [Int?]) -> Int {
    var total = 0

    if values.count == 0 {
        return 0
    }
    
    for value in values {
        if value != nil{
            total += value!
        }
    }
    return total
}

print(total([8, 6, 7, 5, 3, 0, 9]))
print(total([23, 25, nil, 193, 13]))
print(total([nil, nil, nil]))

/*:
 * Callout(Problem):
   - Implement an `earlierIgnoringCase(of: and:)` function that returns which of two *optional* input strings is alphabetically earlier than the other, ignoring the letter case of the input strings.
     - When exactly one of the input strings is `nil`, return the other string.
     - When both input strings are `nil`, return `nil`.
   - Examples are provided below in commented code.
   - When you think your implementation is working, comment out the sample calls to the method and check that the results match your expectations.
 */

// your code here

//print(earlierIgnoringCase(of: "elon", and: "Phoenix")) // should return Optional("elon")
//print(earlierIgnoringCase(of: "Phoenix", and: "elon")) // should return Optional("elon")
//print(earlierIgnoringCase(of: "Elon", and: "phoenix")) // should return Optional("elon")
//print(earlierIgnoringCase(of: "phoenix", and: "Elon")) // should return Optional("elon")
//print(earlierIgnoringCase(of: nil, and: "Phoenix")) // should return Optional("Phoenix")
//print(earlierIgnoringCase(of: "elon", and: nil)) // should return Optional("elon")
//print(earlierIgnoringCase(of: nil, and: nil)) // should return nil (the value, not the String)
