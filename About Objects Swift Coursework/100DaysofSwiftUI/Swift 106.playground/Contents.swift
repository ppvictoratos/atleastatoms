

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

//os, the loop variable, only exists in this loop, meaning it's only accessible between the braces
for os in platforms {
    //loop body
    print("Swift works great on \(os).")
    //one cycle thorugh the body is a loop iteration
}

//1...12 is a range
for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}

//nested loops
for i in 1...12 {
    print("The \(i) times table:")
    
    for j in 1...12 {
        print(" \(j) x \(i) is \(j * i)")
    }
    
    print() //new line
}

//x...y counts from x to y and includes y
//x..<y counts from x to y and excludes y
for i in 1...5 {
    print("Counting from 1 through 5: \(i)")
}

print()

for i in 1..<5 {
    print("Counting 1 up to 5 \(i)")
}

//if you don't want the loop variable, use an underscore
var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)

let names = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[0])
print(names[1...3]) //this carries a risk.. what if our array doesn't have 4 items?
print(names[1...]) //a one-sided range

var countdown = 10

//while loops are less common and will continue to act as long as the condition is true
while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}

print("Blast off!")

//this creates a random int
let id = Int.random(in: 1...1000)

//this creates a random decimal
let amount = Double.random(in: 0...1)

//create an integer to store a dice roll
var roll = 0

//carry o looping until we reach 20
while roll != 20 {
    //roll a new dice and print what is was
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

//if we're here it means the loop ended - we got a 20!
print("Critical hit!\n")

//The for loop is used with a finite sequence
//The while loop comes in handy when we need to keep a loop going until we're ready to exit

//true, this prints 5 lines
var counter = 2
while counter < 64 {
    print("\(counter) is a power of 2.")
    counter *= 2
}

//true, this prints 5 lines
var page: Int = 0
while page <= 5 {
    page += 1
    print("I'm reading page \(page).")
}

//this will print nothing
var itemsSold: Int = 0
while itemsSold < 5000 {
    itemsSold += 100
    if itemsSold % 1000 == 1000 {
        print("\(itemsSold) items sold - a big milestone!")
    }
}

//If you call continue inside a loop body, Swift will immediately stop the current loop iteration
    //and jump to the next item
//I'm done with this current run of the loop
let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }
    
    print("Found picture: \(filename)")
}

//A break will exit a loop immediately and skip all remaining iterations
//"I'm done with this loop altogether, so get out completely."
let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
        
        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)
print()

//fizz buzz

for i in 0...100 {
    //if # is a multiple of 3, print "Fizz"
    if i % 5 == 0 && i % 3 == 0  {
        print("\(i) = FizzBuzz")
    //if # is a multiple of 5, print "Buzz"
    } else if i % 3 == 0 {
        print("\(i) = Fizz")
    //if # is a multiple of 3 & 5, print "FizzBuzz"
    } else if i % 5 == 0 {
        print("\(i) = Buzz")
    } else {
        print("\(i)")
    }
}
