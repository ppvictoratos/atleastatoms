//: # Enumerations (enums)
enum ElonSchool {
    case artsAndSciences
    case business
    case communications
    case education
}

let computerScienceSchool = ElonSchool.artsAndSciences
print(computerScienceSchool)

var economicsSchool = ElonSchool.business
print(economicsSchool)
/*:
 A feature that exists in Java but that you might not encountered is an *enumeration*.  This feature is used when you want to define your own type that has a fixed number of distinct states, descriptions, etc.  Let's take Elon's undergraduate program as an example... each department falls into one of the following colleges and schools.
 
 - Arts & Sciences
 - Business
 - Communications
 - Education
 
 An enumeration is an appropriate way to represent these schools in code.
 */
economicsSchool = .artsAndSciences
print(economicsSchool)
/*:
 Recall that Swift infers type and variables retain type.  So when we re-assign a value to `economicsSchool` we can omit the `ElonSchool` indicator because `economicsSchool` is already known to be an `ElonSchool` type of variable.  You will see this style used frequently in the online resources and sample code.
 
 [Previous](@previous) | [Next](@next)
 */
