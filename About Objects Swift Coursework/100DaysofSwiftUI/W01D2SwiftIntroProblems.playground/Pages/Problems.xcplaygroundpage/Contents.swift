//: # Problems
/*:
 * Callout(Problem): Array practice.
   - Create an array named beatles consisting of the original band members (Paul, George, John, and Pete).
   - Print the array
   - Alter the array to replace Pete with Ringo
   - Print the array again
 */


// your code here

var theBeatles = ["Paul", "George", "John", "Pete"]
print(theBeatles)
print()
theBeatles[3] = "Ringo"
print(theBeatles)
print()


/*:
 * Callout(Problem): Total Function
   - Write a function that accepts an un-labeled array of `Int` values as input and returns the total of the array.
   - Create an array constant with some sample values.
   - Call your function and store the result in another constant.
   - Print each constant and print a full sentence including the constants (use string interpolation).
   - Example: `totalOf([8, 6, 7, 5, 3, 0, 9])` should return `38`
 */


// your code here

let sampleNumbers = [2, 4, 6, 8, 22, 500]

func totalOf (_ sampleNumbers: [Int]) -> Int {
    var total = 0
    
    for number in sampleNumbers{
        print(number)
        total += number
    }
    return total
}

var sum = totalOf(sampleNumbers)
print()
print("The total of the given numbers is: \(sum)")


// your code here
let sampleNumbersForAverage = [2, 4, 6, 8, 22, 500]

func averageOf (_ sampleNumbers: [Int]) -> Float {
    var average: Float = 0
    var total = 0
    
    for number in sampleNumbers{
        total += number
    }
    average = Float(total / sampleNumbersForAverage.count)
    return average
}

var average = averageOf(sampleNumbersForAverage)
print()
print("The total of the given numbers is: \(average)")

/*:
 * Callout(Problem): Earliest Name
   - Write a function that accepts an array labeled `names` as input and returns the earliest string (alphabetically) in the array.
   - Call your function on the beatles array and print the result
   - Example: `earliestNameIn(names: beatles)` should return `George`
 */


// your code here

func earliestNameIn(listOfNames: [String]) -> String{
    if (listOfNames.count == 0){
        return "empty string"
    }
    var earlierName = listOfNames[0]
    
    for name in listOfNames{
        if name < earlierName{
            earlierName = name
        }
    }
    
    return earlierName
}

let earliestName = earliestNameIn(listOfNames: theBeatles)
print()
print("The earliest name in the list given is: \(earliestName)")
/*:
 * Callout(Problem): Index Of
   - Write a function that accepts a `String` labeled `item` and an array with a label name of `in` and a parameter name of `array` that returns an Int indicating the first index where item occurs in the array (or -1 if the item does not appear in the array)
   - Call your function twice (once with an input in the array and once with an input not in the array) and print each result.
   - Example: `indexOf(item: "John", in: beatles)` should return `2`
 */

// your code here

func indexOf(item: String, in array: [String]) -> Int {
    for index in 0..<array.count {
        if item == array[index] {
            return index
        }
    }
    return -1
}

// Returning -1 is a Java-style approach to this problem, not a Swift-style approach
// Also, Swift already has a firstIndex(of:) defined for Arrays.
// We'll investigate both of these points in a moment

let johnIndex = indexOf(item: "John", in: theBeatles)
let peteIndex = indexOf(item: "Pete", in: theBeatles)
print("johnIndex: \(johnIndex)")
print("peteIndex: \(peteIndex)")

/*:
 * Callout(Challenge Problem): Count of
   - Write a function that accepts a `Character` labeled letter and an array labeled and named as in the previous problem.  Return the number of occurrences of the letter among all of the array items.
   - Call your function several times with different letters and print each result
   - Hint: A character can be indicated with quotes, just like a String
   - Hint: You can use a `for-in` loop on a String to iterate over each of the characters of the String
   - Example: `countOf(letter: "o", in: beatles)` should return `3`
 */


// your code here

