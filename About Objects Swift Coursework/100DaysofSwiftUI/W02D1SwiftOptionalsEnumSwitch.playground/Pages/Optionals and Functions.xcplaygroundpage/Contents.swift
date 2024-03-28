//: # Optionals and Functions
/*: In addition to simple variables as optionals...
 - Functions can return optionals, such as the array method `firstIndex(of:)`
 - Functions can accept optionals as input. When calling the method, we can use a regular value or an optional value.
 */
// the output is an optional String
func earliestIn(_ values: [String]) -> String? {
    // any empty array does not have an earliest value
    if values.count == 0 {
        return nil
    }
    
    // we now know that there is at least one element in the array
    var earliest = values[0]
    for value in values {
        if value < earliest {
            earliest = value
        }
    }
    return earliest
}

print("--- Earliest In ---")
print(earliestIn([]))
print(earliestIn(["elon"]))
print(earliestIn(["elon", "Phoenix"]))

// the input is an optional Float
func getReport(value: Float?) -> String {
    // we use the same name in optional binding
    if let actualValue = value {
        // inside of the if, the variable is unwrapped (no longer an optional)
        if actualValue < 0 {
            return "---"
        } else if actualValue > 0 {
            return "+++"
        } else {
            return "..."
        }
    } else {
      return "n/a"
    }
}

print()
print("--- Get Report ---")
var highSchoolGradePointAverage: Float = 4.1
let highSchoolGPAReport = getReport(value: highSchoolGradePointAverage)
print(highSchoolGPAReport)

// You don't have a college GPA if you have not completed a class
var collegeGradePointAverage: Float? = nil
let collegeGPAReport = getReport(value: collegeGradePointAverage)
print(collegeGPAReport)

// an array of optional Floats
var scores: [Float?] = [0.2, -0.1, 0, nil, 0.9, -0.9]

print()
print("--- Let's try an array of optional Float variables ---")
for score in scores {
    let report = getReport(value: score)
    print("\(report) \(score)")
}

// an array of Floats
var precipitationMeasures: [Float] = [0, 0, 0.05, 0.1, 1.0]

print()
print("--- And now for an array of regular Float variables ---")

for measure in precipitationMeasures {
    let report = getReport(value: measure)
    print("\(report) \(measure)")
}
//: [Previous](@previous) | [Next](@next)
