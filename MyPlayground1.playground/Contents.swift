//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//------------------------------Strings and Characters--------------------------------------------------//
var optionalString : String? = "testing"
print(type(of: optionalString)) // where x is an optional string

let message = "Then he said, \"I \u{1F496} you!\""

let words = ["apple", "orange", "banana"]
let str1 = words.joined(separator: " & ")
["a", "b", "c"].joined()


let str2 = "ที่👌①!"
Array(str2.characters)
str2.unicodeScalars.map{ $0.value } // 32 bit
Array(str2.utf8)
Array(str2.utf16)


// If the string is empty, replace it with a fallback:
let result = str.isEmpty ? "fallback string" : str

// "LATIN SMALL LETTER A WITH ACUTE" == "LATIN SMALL LETTER A" + "COMBINING ACUTE ACCENT"
"\u{e1}" == "a\u{301}"  // true

"fortitude".hasPrefix("fort")      // true
"Swift Language".hasSuffix("age")  // true

let reversedCharacters = str.characters.reversed()
let reversedString = String(reversedCharacters)




//Check if String contains Characters from a Defined Set
let letters = CharacterSet.letters

let phrase = "Test case"
let range = phrase.rangeOfCharacter(from: letters)

// range will be nil if no letters is found
if let test = range {
    print("letters found")
}
else {
    print("letters not found")
}

//String iteration

let string = "My fantastic string"
var currentIndex = string.startIndex

while currentIndex != string.endIndex {
    print(string[currentIndex])
    currentIndex = string.index(after: currentIndex)
}

//String to data

let data = str.data(using: .utf8)
let str3 = String(data: data!, encoding: .utf8)

//Formatting Strings

let number: Float = 3.14159
let str4 = String(format: "%.2f", number) // 3.14


let number1: Int = 7
let str6 = String(format: "%03d", number1) // 007

let number2: Int = 13627
let s1 = String(number2, radix: 16, uppercase: true) //353B
let s2 = String(number2, radix: 16) // 353b


let s3 = String(number2, radix: 36) // aij // random radix




//Remove leading and trailing WhiteSpace and NewLine


let someString = "  Swift Language  \n"

let trimmedString = someString.trimmingCharacters(in: .whitespacesAndNewlines)
// "Swift Language"

let trimmedWhiteSpace = someString.trimmingCharacters(in: .whitespaces)
// "Swift Language  \n"

let trimmedNewLine = someString.trimmingCharacters(in: .newlines)
// "  Swift Language  "


//-------------------------------------Enums--------------------------------------------------//

enum Direction { case up, down, left, right }
print(Direction.up)  // prints "up"
debugPrint(Direction.up)  // prints "Direction.up"


//Associated values
enum Action {
    case jump
    case kick
    case move(distance: Float)  // The "move" case has an associated distance
}

let action = Action.move(distance: 10.5)
let action2 = Action.move(distance: 10.5)

switch action {
case .jump:
    print("jump")
case .kick:
    print("kick")
case .move(let distance):  // or case let .move(distance):
    print("Moving: \(distance)")
}

//A single case extraction can be done using if case:
if case .move(let distance) = action {
    print("Moving: \(distance)")
}

//The guard case syntax can be used for later use extraction:
func testEnum(){

    guard case .move(let distance) = action else {
        print("Action is not move")
        return
    }
}

//Enums with associated values are not Equatable by default. Implementation of the == operator must be done manually:

extension Action: Equatable { }

func ==(lhs: Action, rhs: Action) -> Bool {
    switch lhs {
    case .jump: if case .jump = rhs { return true }
    case .kick: if case .kick = rhs { return true }
    case .move(let lhsDistance): if case .move (let rhsDistance) = rhs { return lhsDistance == rhsDistance }
    }
    return false
}

if action == action2{
    print("hey")
    
}
else{
    print("bey")
}


//Indirect Payloads
//Normally, enums can't be recursive (because they would require infinite storage):
enum Tree<T> {
    case leaf(T)
    indirect case branch(Tree<T>, Tree<T>)  // error: recursive enum 'Tree<T>' is not marked 'indirect'
}

//The indirect keyword makes the enum store its payload with a layer of indirection, rather than storing it inline. You can use this keyword on a single case:

let tree = Tree.branch(.leaf(1), .branch(.leaf(2), .leaf(3)))


//indirect also works on the whole enum, making any case indirect when necessary:
indirect enum Tree2<T> {
    case leaf(T)
    case branch(Tree2<T>, Tree2<T>)
}

//raw value and hash value

enum MetasyntacticVariable: Int {
    case foo  // rawValue is automatically 0
    case bar  // rawValue is automatically 1
    case baz = 7
    case quux  // rawValue is automatically 8
}

let quux = MetasyntacticVariable(rawValue: 8)// rawValue is 8
quux?.hashValue //hashValue is 3

//Enums in Swift are much more powerful than some of their counterparts in other languages, such as C. They share many features with classes and structs, such as defining initialisers, computed properties, instance methods, protocol conformances and extensions.

protocol ChangesDirection {
    mutating func changeDirection()
}

enum Direction1 {
    
    // enumeration cases
    case up, down, left, right
    
    // initialise the enum instance with a case
    // that's in the opposite direction to another
    init(oppositeTo otherDirection: Direction1) {
        self = otherDirection.opposite
    }
    
    // computed property that returns the opposite direction
    var opposite: Direction1 {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
}

// extension to Direction that adds conformance to the ChangesDirection protocol
extension Direction1: ChangesDirection {
    mutating func changeDirection() {
        self = .left
    }
}

var dir = Direction1(oppositeTo: .down) // Direction.up

dir.changeDirection() // Direction.left

let opposite = dir.opposite // Direction.right


//-------------------------------------Enums--------------------------------------------------//


protocol MyProtocol {
    init(value: Int)                      // required initializer
    func doSomething() -> Bool            // instance method
    var message: String { get }           // instance read-only property
    var value: Int { get set }            // read-write instance property
    subscript(index: Int) -> Int { get }  // instance subscript
    static func instructions() -> String  // static method
    static var max: Int { get }           // static read-only property
    static var total: Int { get set }     // read-write static property
}











