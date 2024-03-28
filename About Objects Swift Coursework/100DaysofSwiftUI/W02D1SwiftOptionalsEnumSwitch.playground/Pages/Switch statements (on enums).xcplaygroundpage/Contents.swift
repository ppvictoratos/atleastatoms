//: # Switch statements (on enums)
enum ElonSchool {
    case artsAndSciences
    case business
    case communications
    case education
}

let economicsSchool = ElonSchool.business

switch economicsSchool {
case .artsAndSciences:
    print("A&S")
case .business:
    print("LSB")
case .communications:
    print("COM")
case .education:
    print("EDU")
}
//: A `switch` statement is another Java feature that you might not encountered before.  It is similar to an if/else if statement but has a special feature: it must provide a *case* for each of the possible values of the variable or expression being evaluated.  Switch statements are frequently used with enumeration types to guarantee that each possibilty of the enumeration is taken care of.  Your code will not compile unless you cover every case.
switch economicsSchool {
case .artsAndSciences:
    print("Liberal Arts")
case .business, .communications:
    print("Professional")
case .education:
    print("Education")
}
//: When multiple cases result in the same action, you can combine them using commas.
switch economicsSchool {
case .artsAndSciences:
    print("Liberal Arts")
default:
    print("Not in the Liberal Arts")
}
/*:
 If you need to evaluate only a subset of cases and the remaining cases can be handled in the same way, a `default:` indicator can used to adress all remaining cases and ensure the switch statement is exhaustive (i.e. that you cover every case).
 
 [Previous](@previous)
 */
