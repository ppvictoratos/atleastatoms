//: # Optionals and Arrays
var arrayOfOptionalInts: [Int?] = [8, 6, 7, 5, nil, 0, 9]
var optionalArrayOfRegularInts: [Int]? = [2, 7, 2, 4, 4]
var optionalArrayOfOptionalInts: [Int?]? = [4, 5, nil]

// Uncomment the line below to see the compiler error.
// arrayOfOptionalInts = nil

// Uncomment the line below... and notice there are no errors
// arrayOfOptionalInts = []

// Uncomment the line below to see the compiler error.
// optionalArrayOfRegularInts = [2, nil, 2, 4, 4]

// Uncomment the line below... and notice there are no errors
// optionalArrayOfRegularInts = []

// Uncomment the lines below... and notice there are no errors.
// optionalArrayOfOptionalInts = nil
// optionalArrayOfOptionalInts = [4, 5, 1]
// optionalArrayOfOptionalInts = []
/*:
 The most common situation you will encounter is `[Int?]`, which is a variable that will definitely be an array but might have nil as some of its values.  Here's a text description of each of the situations described above.
 - `[Int?]` is an array of optionals.  The array itself cannot be `nil`, but any of its values can be `nil`.
 - `[Int]?` is an optional array.  The array itself can be `nil` but *none* of its values can be `nil`.
 - `[Int?]?` is an optional array of optionals.  The array itself can be `nil` and any of its values can be `nil`.
 */
//: [Previous](@previous) | [Next](@next)
