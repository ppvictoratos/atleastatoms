//: # Be careful with optional strings
var addressLine1 = "100 Campus Drive"
print(addressLine1)

print("----------------")

var addressLine2: String? = ""
print("Assigned \"\" and prints \(addressLine2)")

addressLine2 = nil
print("Assigned nil and prints \(addressLine2)")

addressLine2 = "nil"
print("Assigned \"nil\" and prints \(addressLine2)")

if let line2 = addressLine2 {
    print("Unwrapped value: \(line2)")
} else {
    print("Cannot be unwrapped; value must be nil")
}
//: [Previous](@previous) | [Next](@next)
