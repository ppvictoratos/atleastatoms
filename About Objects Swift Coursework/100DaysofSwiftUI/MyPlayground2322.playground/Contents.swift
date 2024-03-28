import Cocoa
import Foundation

let histogramArray = [1, 1, 2, 2, 2, 4, 6, 9]
let histogramArray2 = [-2, -20, 0, 1, 22, 211231]
// 0 - 9

// filter out anything above 9 or below 0
let filtered = histogramArray.filter { $0 > -1 && $0 < 10 }
print(filtered)

let filtered2 = histogramArray2.filter { $0 > -1 && $0 < 10 }
print(filtered2)

// create dictionary for each unique value that exists in the array

var dictionary = [Int: Int]()
  //count how many unique values there are in an [Int]
  let unique = Array(Set(histogramArray))
  print(unique)

  //using unique count create a variable for each unique and then add one to it if the unique int appears again

// populate dictionary for each occurance of each value
  //count how many entries of each value there are
  for x in histogramArray {
      if dictionary.contains(where: x) {
          dictionary[x]! += 1
      } else {
        dictionary[x] = 1
      }
  }
