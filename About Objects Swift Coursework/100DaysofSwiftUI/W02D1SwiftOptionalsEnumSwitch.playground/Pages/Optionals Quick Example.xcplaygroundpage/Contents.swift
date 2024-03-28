//: # Optionals Quick Example
var regularInteger = 340

// Uncomment the following line and notice the compiler error
// regularInteger = nil

var optionalInteger: Int? = 340
print("optionalInteger after assigning 340: \(optionalInteger)")

optionalInteger = nil
print("optionalInteger after assigning nil: \(optionalInteger)")

print()
print("--- Unwrapping via conditional binding ---")

if let unwrappedInteger = optionalInteger {
    print("unwrappedInteger is \(unwrappedInteger)")
} else {
    print("Could not unwrap optionalInteger because its value is nil")
}

optionalInteger = 340

if let unwrappedInteger = optionalInteger {
    print("unwrappedInteger is \(unwrappedInteger)")
} else {
    print("Could not unwrap optionalInteger because its value is nil")
}
//: [Previous](@previous) | [Next](@next)
