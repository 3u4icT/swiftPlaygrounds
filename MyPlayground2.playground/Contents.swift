//: Playground - noun: a place where people can play

import UIKit

//-------------------------------Optionals--------------------//



//Optionals can be created by appending either a ! or a ? to the variable type

var numberOne: Int! = nil
var numberTwo: Int? = nil



//? optionals must be explicitly unwrapped, and should be used if you aren't certain whether or not the variable will have a value when you access it.
//! optionals are automatically unwrapped, and should only be used when you are certain that the variable will have a value when you access it. For example, a global UIButton! variable that is initialized in viewDidLoad()



//You can use the nil coalescing operator to unwrap a value if it is non-nil, otherwise provide a different value:
//This operator is able to short-circuit, meaning that if the left operand is non-nil, the right operand will not be evaluated:

func someExpensiveComputation() -> String { return "" }

var foo : String? = "a string"
let str = foo ?? someExpensiveComputation()

//In this example, as foo is non-nil, someExpensiveComputation() will not be called.

//You can also chain multiple nil coalescing statements together

var bar : String?

let baz = foo ?? bar ?? "fallback string"

//unwrapping an optional

//You can conditionally unwrap an Optional using optional binding and force unwrap an Optional using the ! operator.

//Conditionally unwrapping effectively asks "Does this variable have a value?" while force unwrapping says "This variable has a value!".

//If you force unwrap a variable that is nil, your program will throw an unexpectedly found nil while unwrapping an optional exception and crash, so you need to consider carefully if using ! is appropriate.


var number: Int? = 1
if let unwrappedNumber = number {       // Has `number` been assigned a value?
    print("number: \(unwrappedNumber)") // Will not enter this line
} else {
    print("number was not assigned a value")
}


func unwrapvalue(){

    guard let unwrappedNumber = number else {
        return
    }
    print("number in method : \(unwrappedNumber)")
}

unwrapvalue()

//Note that the scope of the unwrappedNumber variable is inside the if-let statement and outside of the guard block


//You can chain unwrapping of many optionals, this is mainly useful in cases that your code requires more then variable to run correctly

var firstName:String?
var lastName:String?

if let fn = firstName, let ln = lastName {
    print("\(fn) + \(ln)")//pay attention that the condition will be true only if both optionals are not nil.
}

//Note that all the variables have to be unwrapped in order to pass successfully the test, otherwise you would have no way to determine which variables were unwrapped and which weren't.

//You can chain conditional statements using your optionals immediately after it is unwrapped. This means no nested if - else statements!

var firstName1:String? = "Bob"
var myBool1:Bool? = false

if let fn = firstName1, fn == "Bob", let bool = myBool1, !bool {
    print("firstName is bob and myBool was false!")
}


//Optional Chaining
//The reason that Optional Chaining is named as such is because ‘optionality’ will be propagated through the members you call/access. What this means is that the return values of any members used with optional chaining will be optional, regardless of whether they are typed as optional or not.

struct Foo2 {
    var bar : Int
    func doSomething() {  }
}

let foo2 : Foo2? = Foo2(bar: 5)
//print(foo2?.bar) // Optional(5)

//Here foo?.bar is returning an Int? even though bar is non-optional, as foo itself is optional.

//As optionality is propagated, methods returning Void will return Void? when called with optional chaining. This can be useful in order to determine whether the method was called or not (and therefore if the optional has a value).


if foo2?.doSomething() != nil {
    print("foo is non-nil, and doSomething() was called")
} else {
    print("foo is nil, therefore doSomething() wasn't called")
}
//Here we’re comparing the Void? return value with nil in order to determine whether the method was called (and therefore whether foo is non-nil)


//-----------------------------Array--------------------------------------------
// A mutable array of Strings, initially empty.

var arrayOfStrings: [String] = []      // type annotation + array literal
var arrayOfStrings1 = [String]()        // invoking the [String] initializer
var arrayOfStrings2 = Array<String>()   // without syntactic sugar


//An array literal is written with square brackets surrounding comma-separated elements
// Create an immutable array of type [Int] containing 2, 4, and 7
let arrayOfInts = [2, 4, 7]

// An immutable array of type [String], containing ["Example", "Example", "Example"]
let arrayOfStrings4 = Array(repeating: "Example",count: 3)


let dictionary = ["foo" : 4, "bar" : 6]

// An immutable array of type [(String, Int)], containing [("bar", 6), ("foo", 4)]
let arrayOfKeyValuePairs = Array(dictionary)

//In Swift, a multidimensional array is created by nesting arrays: a 2-dimensional array of Int is [[Int]] (or Array<Array<Int>>).

let array2x3 = [
    [1, 2, 3],
    [4, 5, 6]
]
// array2x3[0][1] is 2, and array2x3[1][2] is 6.

var array3x4x5 = Array(repeating: Array(repeating: Array(repeating: 0,count: 5),count: 4),count: 3)


//Extracting values of a given type from an Array with flatMap(_:)

let things: [Any] = [1, "Hello", 2, true, false, "World", 3]

let numbers = things.flatMap { $0 as? Int }
numbers

//extension Sequence {
//    public func flatMap<T>(@noescape transform: @noescape (Self.Generator.Element) throws -> T?) rethrows -> [T]
//}

//The difference with this version of flatMap(_:) is that it expects the transform closure to return an Optional value T? for each of the elements. It will then safely unwrap each of these optional values, filtering out nil – resulting in an array of [T].


let strings = ["1", "foo", "3", "4", "bar", "6"]

let numbersThatCanBeConverted = strings.flatMap{ Int($0) }

print(numbersThatCanBeConverted) // [1, 3, 4, 6]

//You can also use flatMap(_:)'s ability to filter out nil in order to simply convert an array of optionals into an array of non-optionals:

let optionalNumbers : [Int?] = [nil, 1, nil, 2, nil, 3]

let numbers1 = optionalNumbers.flatMap { $0 }

print(numbers) // [1, 2, 3]




//extension SequenceType {
//    public func flatMap<S : SequenceType>(transform: (Self.Generator.Element) throws -> S) rethrows -> [S.Generator.Element]
//}

//Each sequence from the transformation will be concatenated, resulting in an array containing the combined elements of each sequence – [S.Generator.Element]


let primes = ["2", "3", "5", "7", "11", "13", "17", "19"]
let allCharacters = primes.flatMap { $0.characters }
allCharacters
// => "["2", "3", "5", "7", "1", "1", "1", "3", "1", "7", "1", "9"]"

//primes is a [String] (As an array is a sequence, we can call flatMap(_:) on it).
//The transformation closure takes in one of the elements of primes, a String (Array<String>.Generator.Element).
//The closure then returns a sequence of type String.CharacterView.
//The result is then an array containing the combined elements of all the sequences from each of the transformation closure calls – [String.CharacterView.Generator.Element].

//Flattening a multidimensional array
//This can simply be done by returning the given element $0 (a nested array) in the closure


// A 2D array of type [[Int]]
let array2D = [[1, 3], [4], [6, 8, 10], [11]]

// A 1D array of type [Int]
let flattenedArray = array2D.flatMap { $0 }

print(flattenedArray) // [1, 3, 4, 6, 8, 10, 11]



//Combining an Array's elements with reduce(_:combine:)

//reduce(_:combine:) can be used in order to combine the elements of a sequence into a single value. It takes an initial value for the result, as well as a closure to apply to each element – which will return the new accumulated value


let numbers3 = [2, 5, 7, 8, 10, 4]

let sum = numbers3.reduce(0) {accumulator, element in
    return accumulator + element
}

print(sum) // 36

//As in this example, we're passing an (Int, Int) -> Int closure to reduce, which is simply outputting the addition of the two inputs – we can actually pass in the + operator directly, as operators are functions in Swift:

let sum1 = numbers3.reduce(0, +)

//Removing element from an array without knowing it's index

extension Array where Element : Equatable {
    
    mutating func remove(element:Element) -> Element? {
        return index(of: element).map {
            remove(at: $0)
        }
    }
}

//Not running
//var array = ["abc", "lmn", "pqr", "stu", "xyz"]
//array.remove("lmn")
//print("\(array)")    //["abc", "pqr", "stu", "xyz"]
//
//array.remove("nonexistent")
//print("\(array)")    //["abc", "pqr", "stu", "xyz"]
////if provided element value is not present, then it will do nothing!



//You can use the filter(_:) method on SequenceType in order to create a new array containing the elements of the sequence that satisfy a given predicate, which can be provided as a closure.

let numbers4 = [22, 41, 23, 30]

let evenNumbers = numbers4.filter { $0 % 2 == 0 }

print(evenNumbers)  // [22, 30]

//Sorting

let words = ["Hello", "Bonjour", "Salute", "Ahola"]
let sortedWords = words.sorted()
print(sortedWords) // ["Ahola", "Bonjour", "Hello", "Salute"]

var mutableWords = ["Hello", "Bonjour", "Salute", "Ahola"]
mutableWords.sort()
print(mutableWords) // ["Ahola", "Bonjour", "Hello", "Salute"]

//You can pass a closure as an argument for sorting:

let words1 = ["Hello", "Bonjour", "Salute", "Ahola"]
let sortedWords1 = words1.sorted{ $0 > $1 }
print(sortedWords1) // ["Salute", "Hello", "Bonjour", "Ahola"]


//To properly sort Strings by the numeric value they contain, use compare with the .numeric option
let files = ["File-42.txt", "File-01.txt", "File-5.txt", "File-007.txt", "File-10.txt"]
let sortedFiles = files.sorted() { $0.compare($1, options: .numeric) == .orderedAscending }
print(sortedFiles) // ["File-01.txt", "File-5.txt", "File-007.txt", "File-10.txt", "File-42.txt"]


//Subscripting an Array with a Range : returns ArraySlice
let words3 = ["Hey", "Hello", "Bonjour", "Welcome", "Hi", "Hola"]
let selectedWords = Array(words3[2...4]) // ["Bonjour", "Welcome", "Hi"]


//min and max element

struct Vector2 {
    let dx : Double
    let dy : Double
    
    var magnitude : Double {return sqrt(dx*dx+dy*dy)}
}

let vectors = [Vector2(dx: 3, dy: 2), Vector2(dx: 1, dy: 1), Vector2(dx: 2, dy: 2)]


let lowestMagnitudeVec2 = vectors.min { $0.magnitude < $1.magnitude }
let highestMagnitudeVec2 = vectors.max { $0.magnitude < $1.magnitude }
lowestMagnitudeVec2
highestMagnitudeVec2

//As Array conforms to SequenceType, we can use map(_:) to transform an array of A into an array of B using a closure of type (A) throws -> B.
let numbers5 = [1, 2, 3, 4, 5]
let words2 = numbers5.map { String($0) }
print(words2) // ["1", "2", "3", "4", "5"]


//Accessing indices safely

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}


if let thirdValue = numbers5[safe: 2] {
    print(thirdValue)
}

//Copied arrays will share the same space in memory as the original until they are changed. As a result of this there is a performance hit when the copied array is given its own space in memory as it is changed for the first time.


//----------------------------------Tuple-------------------------------------------//

//We can use a tuple type as the return type of a function to enable the function to return a single tuple containing multiple values


let namedTuple = (first: 1, middle: "dos", last: 3)

// Values can be read with the named property
print(namedTuple.first)  // 1
print(namedTuple.middle) // dos

// And still with the index number
print(namedTuple.2)      // 3


//Decomposing into individual variables

let myTuple = (name: "Some Name", age: 26)
let (first, second) = myTuple

print(first) // "Some Name"
print(second)  // 26


// Define a circle tuple by its center point and radius
typealias Circle = (center: (x: CGFloat, y: CGFloat), radius: CGFloat)

//If you find yourself doing this too often, however, you should consider using a struct instead

//Tuples are useful to swap values between 2 (or more) variables without using temporary variables.

//Use tuples in a switch

let switchTuple = (firstCase: true, secondCase: false)

switch switchTuple {
case (true, false): break
// do something
case (true, true): break
// do something
case (false, true): break
// do something
case (false, false): break
    // do something
}

//---------------------Reading and writing JSON---------//


//You can pass options: .AllowFragments instead of options: [] to allow reading JSON when the top-level object isn't an array or dictionary.

do {
    guard let jsonData = "[\"Hello\", \"JSON\"]".data(using: String.Encoding.utf8) else {
        fatalError("couldn't encode string as UTF-8")
    }
    
    // Convert JSON from NSData to AnyObject
    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
    
    // Try to convert AnyObject to array of strings
    if let stringArray = jsonObject as? [String] {
        print("Got array of strings: \(stringArray.joined(separator: ", "))")
    }
} catch {
    print("error reading JSON: \(error)")
}

//you can pass options: .PrettyPrinted instead of options: [] for pretty-printing.

do {
    // Convert object to JSON as NSData
    let jsonObj = ["het", "dsds"]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
    print("JSON data: \(jsonData)")
    
    // Convert NSData to String
    let jsonString = String(data: jsonData, encoding: .utf8)!
    print("JSON string: \(jsonString)")
} catch {
    print("error writing JSON: \(error)")
}


//example about swiftyJson and freddy : not useful though
 //   http://stackoverflow.com/documentation/swift/223/reading-writing-json/3882/swiftyjson#t=201704251054379345853
//http://stackoverflow.com/documentation/swift/223/reading-writing-json/4881/freddy#t=201704251054379345853

//Simple JSON parsing into custom objects - Imp

//http://stackoverflow.com/documentation/swift/223/reading-writing-json/13796/simple-json-parsing-into-custom-objects#t=201704251054379345853

//NSJSONSerialization.JSONObjectWithData(jsonData, options: jsonReadingOptionsEnum) // Returns an Object from jsonData. This method throws on failure.
//NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions) // Returns NSData from a JSON object. Pass in NSJSONWritingOptions.PrettyPrinted in options for an output that is more readable.


//---------------------------------Closures---------------------------------------------------//

//Closures (also known as blocks or lambdas) are pieces of code which can be stored and passed around within your program

let sayHi = { print("Hello") }
// The type of sayHi is "() -> ()", aka "() -> Void"

sayHi()  // prints "Hello"


//Like other functions, closures can accept arguments and return results or throw errors:



let addInts = { (x: Int, y: Int) -> Int in
    return x + y
}
// The type of addInts is "(Int, Int) -> Int"

let result = addInts(1, 2)  // result is 3

let divideInts = { (x: Int, y: Int) throws -> Int in
    if y == 0 {
       // throw MyErrors.DivisionByZero
    }
    return x / y
}
// The type of divideInts is "(Int, Int) throws -> Int"


//Closures can capture values from their scope:

func makeProducer(x: Int) -> (() -> Int) {
    let closure = { x }  // x is captured by the closure
    return closure
}

// These two function calls use the exact same code,
// but each closure has captured different values.
let three = makeProducer(x: 3)
let four = makeProducer(x: 4)
three()  // returns 3
four()  // returns 4

//syntax

//{ [capture list] (parameters) throws-ness -> return type in body }.


let addOne = { [] (x: Int) -> Int in return x + 1 }
let addOne1 = { [] (x: Int) -> Int in x + 1 }
let addOne2 = { (x: Int) -> Int in x + 1 }
let addOne3 = { x -> Int in x + 1 }
let addOne4 = { x in x + 1 }
let addOne5 = { $0 + 1 }

let addOneOrThrow1 = { [] (x: Int) throws -> Int in return x + 1 }
let addOneOrThrow2 = { [] (x: Int) throws -> Int in x + 1 }
let addOneOrThrow3 = { (x: Int) throws -> Int in x + 1 }
let addOneOrThrow4 = { x throws -> Int in x + 1 }
let addOneOrThrow5 = { x throws in x + 1 }

//The capture list can be omitted if it's empty.
//Parameters don't need type annotations if their types can be inferred.
//The return type doesn't need to be specified if it can be inferred.
//Parameters don't have to be named; instead they can be referred to with $0, $1, $2, etc.
//If the closure contains a single expression, whose value is to be returned, the return keyword can be omitted.
//If the closure is inferred to throw an error, is written in a context which expects a throwing closure, or doesn't throw an error, throws can be omitted

// The closure's type is unknown, so we have to specify the type of x and y.
// The output type is inferred to be Int, because the + operator for Ints returns Int.
let addInts1 = { (x: Int, y: Int) in x + y }

// The closure's type is specified, so we can omit the parameters' type annotations.
let addInts2: (Int, Int) -> Int = { x, y in x + y }
let addInts3: (Int, Int) -> Int = { $0 + $1 }



//Functions may accept closures (or other functions) as parameters:

func foo(value: Double, block: () -> Void) {  }
func foo1(value: Double, block: (Int) -> Int) { }
func foo2(value: Double, block: (Int, Int) -> String) {}

//Trailing closure syntax

//If a function's last parameter is a closure, the closure braces {/} may be written after the function invocation:

foo(value: 3.5, block: { print("Hello") })

foo(value: 3.5) { print("Hello") }


//If a function's only argument is a closure, you may also omit the pair of parentheses () when calling it with the trailing closure syntax

func bar(block: () -> Void) {}

bar() { print("Hello") }

bar { print("Hello") }

//@noescape parameters

//Closure parameters marked @noescape are guaranteed to execute before the function call returns, so using self. is not required inside the closure body:

func executeNow(@noescape block: @noescape () -> Void) {
    // Since `block` is @noescape, it's illegal to store it to an external variable.
    // We can only call it right here.
    block()
}

//func executeLater(block: () -> Void) {
//    dispatch_async(dispatch_get_main_queue()) {
//        // Some time in the future...
//        block()
//    }
//}


//Note that in Swift 3, you no longer mark blocks as @noescape. Blocks are now not escaping by default. In Swift 3, instead of marking a closure as non-escaping, you mark a function parameter that is an escaping closure as escaping using the "@escaping" keyword.


//throws and rethrows

//Closures, like other functions, may throw errors:

func executeNowOrIgnoreError(block: () throws -> Void) {
    do {
        try block()
    } catch {
        print("error: \(error)")
    }
}
//The function may, of course, pass the error along to its caller:

func executeNowOrThrow(block: () throws -> Void) throws {
    try block()
}

//However, if the block passed in doesn't throw, the caller is still stuck with a throwing function:

// It's annoying that this requires "try", because "print()" can't throw!
try executeNowOrThrow { print("Just printing, no errors here!") }
//The solution is rethrows, which designates that the function can only throw if its closure parameter throws:

func executeNowOrRethrow(block: () throws -> Void) rethrows {
    try block()
}

// "try" is not required here, because the block can't throw an error.
executeNowOrRethrow { print("No errors are thrown from this closure") }

// This block can throw an error, so "try" is required.
//try executeNowOrRethrow { throw MyError.Example }
//Many standard library functions use rethrows, including map(), filter(), and indexOf().


//Captures, strong/weak references, and retain cycles
class MyClass {
    func sayHi() { print("Hello") }
    deinit { print("Goodbye") }
}
//When a closure captures a reference type (a class instance), it holds a strong reference by default:

let closure: () -> Void
do {
    let obj = MyClass()
    // Captures a strong reference to `obj`: the object will be kept alive
    // as long as the closure itself is alive.
    closure = { obj.sayHi() }
    closure()  // The object is still alive; prints "Hello"
} // obj goes out of scope
closure()  // The object is still alive; prints "Hello"

//The closure's capture list can be used to specify a weak or unowned reference

let closure1: () -> Void
do {
    let obj = MyClass()
    // Captures a weak reference to `obj`: the closure will not keep the object alive;
    // the object becomes optional inside the closure.
    closure1 = { [weak obj] in obj?.sayHi() }
    closure1()  // The object is still alive; prints "Hello"
} // obj goes out of scope and is deallocated; prints "Goodbye"
closure1()  // `obj` is nil from inside the closure; this does not print anything

let closure2: () -> Void
do {
    let obj = MyClass()
    // Captures an unowned reference to `obj`: the closure will not keep the object alive;
    // the object is always assumed to be accessible while the closure is alive.
    closure2 = { [unowned obj] in obj.sayHi() }
    closure2()  // The object is still alive; prints "Hello"
} // obj goes out of scope and is deallocated; prints "Goodbye"
//closure2()  // crash! obj is being accessed after it's deallocated

//If an object holds onto a closure, which also holds a strong reference to the object, this is a retain cycle. Unless the cycle is broken, the memory storing the object and closure will be leaked (never reclaimed).


//typealias ClosureType = (<parameters>) -> (<returnType>)






















