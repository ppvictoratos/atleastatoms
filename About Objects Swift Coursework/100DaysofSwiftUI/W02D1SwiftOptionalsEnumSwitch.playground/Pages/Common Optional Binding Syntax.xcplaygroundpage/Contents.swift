//: # Common Optional Binding Syntax
func getReport(value: Float?) -> String {
    if let value = value {
        if value < 0 {
            return "---"
        } else if value > 0 {
            return "+++"
        } else {
            return "..."
        }
    } else {
        return "n/a"
    }
}
//: It probably looks a little strange, but Swift allows you to optionally bind to a different constant of the same name.  Inside of the if statement, the constant is no longer optional.  Outside of the if statement, the constant is an optional.
func printFuelReport(type: String?, amount: Float?, measure: String?) {
    if let type = type, let amount = amount, let measure = measure {
        print("Added \(amount)\(measure) of \(type).")
    }
    else {
        print("Fuel Report Unavailable.")
    }
}

printFuelReport(type: "electricity", amount: 12.5, measure: "kWh")
printFuelReport(type: nil, amount: 6.259, measure: "gal")
printFuelReport(type: "gas", amount: nil, measure: "gal")
printFuelReport(type: "gas", amount: 6.259, measure: nil)
printFuelReport(type: "gas", amount: 6.259, measure: "gal")
//: In situations where multilple optionals must all be unwrapped, they can be optionally bound using a single line and commas separating the binding statements.
//: [Previous](@previous) | [Next](@next)
