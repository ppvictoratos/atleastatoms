//: # Optionals
//: Let's start by reconsidering the code below.
func indexOf(_ item: String, in array: [String]) -> Int {
    for index in 0..<array.count {
        if item == array[index] {
            return index
        }
    }
    return -1
}

let beatles = ["Paul", "George", "John", "Ringo"]
let johnIndex = indexOf("John", in: beatles)
let peteIndex = indexOf("Pete", in: beatles)
print("--- Using our indexOf method ---")
print("johnIndex: \(johnIndex)")
print("peteIndex: \(peteIndex)")
//: We're doing more work than we need to here, since among the Swift array methods is `firstIndex(of:)` that we could call instead. We weren't quite ready to use that method in our previous course meeting because Swift's implementation differs in the value returned when the item is not present in the array.
print()
print("--- Using Swift's firstIndex(of:) method ---")
let paulIndex = beatles.firstIndex(of: "Paul")
let postIndex = beatles.firstIndex(of: "Post")
print("paulIndex: \(paulIndex)")
print("postIndex: \(postIndex)")
/*:
 So... we have some compiler warnings and some weird printouts.  Let's look for some help from [the documentation of `firstIndex(of:)`](https://developer.apple.com/documentation/swift/array/2994720-firstindex).
 
 As we saw in the docs, `firstIndex(of:)` returns an `Int?` rather than an `Int`.  The question mark after the type name indicates that the function will return an *optional* `Int`, i.e., sometimes it will return an integer and other times it will return the special value `nil`, equivalent to the Java special value `null`.  Java and Swift take very different approaches to data types and allowing  `null`/`nil` as a value.
 
 Java has primitive types (like `int` and `double`) and object types (like `String`).  Primitive type variables are always some particular value and cannot have the value `null`.  Object type variables *refer* to an object or possibly have the value `null` to indicate that the variable does not refer to any object.  Frequently in Java when you are implementing a method that accepts an object type variable as an input parameter, you must first check whether that variable is `null`.  If you don't check this and try to call a method on a `null` variable during execution of your code, the program will crash by throwing a `NullPointerException` object.
 
 Swift handles things very differently:
 - Swift uses the word `nil` rather than `null`
 - Swift has no primitive types.  `Int` and `String` are not differentiated (technically, both are structures... more on that later).
 - Variables of any regular type (`Int`, `String`, etc.) *never* have the value `nil`
 - If you want to allow a variable to possibly have the value `nil` you must use an *optional type*.
 - The typical way to indicate an optional type is with a question mark `?`, so an optional integer is written as `Int?` and an optional string is written as `String?`
 - If you want to work with the value of an optional, you must first *unwrap* the optional (thus ensuring it actually has a value).
 
 There are a number of ways to deal with optionals in Swift.  Today we will discuss only the most common unwrapping situation you are likely to encounter during the first half of this course: optional binding.
 */
print()
print("--- Unwrapping via conditional binding ---")
if let goodPaulIndex = paulIndex {
    print("Paul is in the array at index \(goodPaulIndex)")
} else {
    print("Paul is not in the array.")
}

if let goodPostIndex = postIndex {
    print("Post is in the array at index \(goodPostIndex)")
} else {
    print("Post is not in the array.")
}
//: [Next](@next)
