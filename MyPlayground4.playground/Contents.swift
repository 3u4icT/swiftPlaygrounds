//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//------------------------------Sets-------------------------------//

//decaring sets
//Sets are unordered collections of unique values. Unique values must be of the same type.
var colors = Set<String>()

//You can declare a set with values by using the array literal syntax.

var favoriteColors: Set<String> = ["Red", "Blue", "Green", "Blue"]
// {"Blue", "Green", "Red"}

var favoriteColors1: Set = ["Red", "Blue", "Green"]
let newColors: Set = ["Purple", "Orange", "Green"]

let intersect = favoriteColors.intersection(newColors) // a AND b
// intersect = {"Green"}


let union = favoriteColors.union(newColors) // a OR b

//Values that don't exist in both sets:

//You can use the exclusiveOr(_:) method to create a new set containing the unique values from either but not both sets.

let exclusiveOr = favoriteColors.symmetricDifference(newColors) // a XOR b
// exclusiveOr = {"Red", "Purple", "Orange", "Blue"}


//You can use the subtract(_:) method to create a new set containing values that aren't in a specific set.
let subtract = favoriteColors.subtracting(newColors) // a - (a AND b)
// subtract = {"Blue", "Red"}



//CountedSet, as suggested by the name, keeps track of how many times a value is present.

let countedSet = NSCountedSet()
countedSet.add(1)
countedSet.add(1)
countedSet.add(1)
countedSet.add(2)

countedSet.count(for: 1) // 3
countedSet.count(for: 2) // 1





//Modifying values in a set

var favoriteColors2: Set = ["Red", "Blue", "Green"]
//favoriteColors = {"Blue", "Green", "Red"}
//You can use the insert(_:) method to add a new item into a set.

favoriteColors2.insert("Orange")
//favoriteColors = {"Red", "Green", "Orange", "Blue"}
//You can use the remove(_:) method to remove an item from a set. It returns optional containing value that was removed or nil if value was not in the set.

let removedColor = favoriteColors2.remove("Red")
//favoriteColors = {"Green", "Orange", "Blue"}
// removedColor = Optional("Red")

let anotherRemovedColor = favoriteColors2.remove("Black")
// anotherRemovedColor = nil


var favoriteColors3: Set = ["Red", "Blue", "Green"]
//favoriteColors = {"Blue", "Green", "Red"}
//You can use the contains(_:) method to check whether a set contains a value. It will return true if the set contains that value.

if favoriteColors3.contains("Blue") {
    print("Who doesn't like blue!")
}
// Prints "Who doesn't like blue!"


//In order to define a Set of your own type you need to conform your type to Hashable


struct Starship: Hashable {
    let name: String
    var hashValue: Int { return name.hashValue }
}

func ==(left:Starship, right: Starship) -> Bool {
    return left.name == right.name
}


let ships : Set<Starship> = [Starship(name:"Enterprise D"), Starship(name:"Voyager"), Starship(name:"Defiant") ]


//------------------------Working with C and Objective-C--------------------------

//Creating Module in Swift

//http://stackoverflow.com/documentation/swift/421/working-with-c-and-objective-c/1418/use-a-module-map#t=201705060947584357437






//If MyFramework contains Objective-C classes in its public headers (and the umbrella header), then import MyFramework is all you need in order to use them from Swift.

//Bridging headers

//A bridging header makes additional Objective-C and C declarations visible to Swift code.

//When adding files to your project, Xcode may offer to create a bridging header automatically:

//http://stackoverflow.com/documentation/swift/421/working-with-c-and-objective-c/1408/using-objective-c-classes-from-swift-code#t=201705060947584357437





//Fine-grained interoperation between Objective-C and Swift

//When an API is marked with NS_REFINED_FOR_SWIFT, it will be prefixed with two underscores (__) when imported to Swift:

//@interface MyClass : NSObject
//- (NSInteger)indexOfObject:(id)obj NS_REFINED_FOR_SWIFT;
//@end
//The generated interface looks like this:

//public class MyClass : NSObject {
//    public func __indexOfObject(obj: AnyObject) -> Int
//}
//Now you can replace the API with a more "Swifty" extension. In this case, we can use an optional return value, filtering out NSNotFound:

//extension MyClass {
//    // Rather than returning NSNotFound if the object doesn't exist,
//    // this "refined" API returns nil.
//    func indexOfObject(obj: AnyObject) -> Int? {
//        let idx = __indexOfObject(obj)
//        if idx == NSNotFound { return nil }
//        return idx
//    }
//}

// Swift code, using "if let" as it should be:
//let myobj = MyClass()
//if let idx = myobj.indexOfObject(something) {
//    // do something with idx
//}
//In most cases you might want to restrict whether or not an argument to an Objective-C function could be nil. This is done using _Nonnull keyword, which qualifies any pointer or block reference:

//void
//doStuff(const void *const _Nonnull data, void (^_Nonnull completion)())
//{
    // complex asynchronous code
//}
//With that written, the compiler shall emit an error whenever we try to pass nil to that function from our Swift code:

//doStuff(
//nil,  // error: nil is not compatible with expected argument type 'UnsafeRawPointer'
//nil)  // error: nil is not compatible with expected argument type '() -> Void'
//The opposite of _Nonnull is _Nullable, which means that it is acceptable to pass nil in this argument. _Nullable is also the default; however, specifying it explicitly allows for more self-documented and future-proof code.

//To further help the compiler with optimising your code, you also might want to specify if the block is escaping:

//void
//callNow(__attribute__((noescape)) void (^_Nonnull f)())
//{
    // f is not stored anywhere
//}
//With this attribute we promise not to save the block reference and not to call the block after the function has finished execution.




//Use the C standard library

//Swift's C interoperability allows you to use functions and types from the C standard library.

//On Linux, the C standard library is exposed via the Glibc module; on Apple platforms it's called Darwin.

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

// use open(), read(), and other libc features




//Using Swift classes from Objective-C code

//http://stackoverflow.com/documentation/swift/421/working-with-c-and-objective-c/1407/using-swift-classes-from-objective-c-code#t=201705060947584357437



//-----------------------Logging in Swift---------------------------

//dump prints the contents of an object via reflection (mirroring).

let names = ["Joe", "Jane", "Jim", "Joyce"]
dump(names)
print(names)

let attributes = ["foo": 10, "bar": 33, "baz": 42]
dump(attributes)

//dump is declared as dump(_:name:indent:maxDepth:maxItems:)
//You can also choose to print only a certain number of items with maxItems:, to parse the object up to a certain depth with maxDepth:, and to change the indentation of printed objects with indent:



//Debug print



//Debug Print shows the instance representation that is most suitable for debugging.

print("Hello")
debugPrint("Hello")

let dict = ["foo": 1, "bar": 2]

print(dict)
debugPrint(dict)
//Yields
    
//    >>> Hello
//    >>> "Hello"
 //   >>> [foo: 1, bar: 2]
 //   >>> ["foo": 1, "bar": 2]
//This extra information can be very important, for example:

let wordArray = ["foo", "bar", "food, bars"]

print(wordArray)
debugPrint(wordArray)
//Yields
    
   // >>> [foo, bar, food, bars]
  //  >>> ["foo", "bar", "food, bars"]
//Notice how in the first output it appears that there are 4 elements in the array as opposed to 3. For reasons like this, it is preferable when debugging to use debugPrint

//Updating a classes debug and print values

//struct Foo: Printable, DebugPrintable {
//    var description: String {return "Clear description of the object"}
//    var debugDescription: String {return "Helpful message for debugging"}
//}
//
//var foo = Foo()
//
//print(foo)
//debugPrint(foo)


//>>> Clear description of the object
//>>> Helpful message for debugging


//-----------------------------------------------Extension-------------------------------------------



//Extensions are used to extend the functionality of existing types in Swift. Extensions can add subscripts, functions, initializers, and computed properties. They can also make types conform to protocols.

//Suppose you want to be able to compute the factorial of an Int. You can add a computed property in an extension:

extension Int {
    var factorial: Int {
        return (1..<self+1).reduce(1, *)
    }
}
let val1: Int = 10

val1.factorial  // returns 3628800


//Extensions can contain convenience initializers.


//Extensions can add new subscripts to an existing type.

//This example gets the character inside a String using the given index:


extension String {
    subscript(offset: Int) -> Character {
        let newIndex = self.index(self.startIndex, offsetBy: offset)
        return self[newIndex] // how is this executing
    }
}

var myString = "StackOverFlow"
print(myString[2]) // a
print(myString[3]) // c


//It is possible to write a method on a generic type that is more restrictive using where sentence.

extension Array where Element: StringLiteralConvertible {
    func toUpperCase() -> [String] {
        var result = [String]()
        for value in self {
            result.append(String(describing: value).uppercased())
        }
        return result
    }
}

let array = ["a","b","c"]
let resultado = array.toUpperCase()

//Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code.
//
//Extensions in Swift can:
//
//Add computed properties and computed type properties
//Define instance methods and type methods
//Provide new initializers
//Define subscripts
//Define and use new nested types
//Make an existing type conform to a protocol


//--------------------------------------Structs----------------------------------------


struct Repository {
    let identifier: Int
    let name: String
    var description: String?
}


//This defines a Repository struct with three stored properties, an integer identifier, a string name, and an optional string description. The identifier and name are constants, as they've been declared using the let-keyword. Once set during initialization, they cannot be modified. The description is a variable. Modifying it updates the value of the structure.

//Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers. The structure receives a memberwise initializer even if it has stored properties that do not have default values.

//Repository contains three stored properties of which only description has a default value (nil). Further it defines no initializers of its own, so it receives a memberwise initializer for free


let newRepository = Repository(identifier: 0, name: "New Repository", description: "Brand New Repository")

//Structures also cannot be compared using identity operator:

//window0 === window1 // works because a window is a class instance
//"hello" === "hello" // error: binary operator '===' cannot be applied to two 'String' operands
//Every two structure instances are deemed identical if they compare equal.

//Collectively, these traits that differentiate structures from classes are what makes structures value types.


//Structs cannot inherit

//Unlike classes, structures cannot inherit:

//class MyView: NSView { }  // works

//struct MyInt: Int { } // error: inheritance from non-protocol type 'Int'
//Structures, however, can adopt protocols:

//struct Vector: Hashable { ... }  // works


//Mutating a Struct

//A method of a struct that change the value of the struct itself must be prefixed with the mutating keyword

struct Counter {
    private var value = 0
    
    mutating func next() {
        value += 1
    }
}
//When you can use mutating methods

//The mutating methods are only available on struct values inside variables.

var counter = Counter()
counter.next()
//When you can NOT use mutating methods

//On the other hand, mutating methods are NOT available on struct values inside constants

//let counter1 = Counter()
//counter1.next()
//  error: cannot use mutating member on immutable value: 'counter' is a 'let' constant


//-------------------------------------Error Handling-----------------------------------

//func reticulateSplines() throws -> Int  // may either return a value or throw an error


//Any value which conforms to the ErrorType protocol (including NSError objects) can be thrown as an error. Enumerations provide a convenient way to define custom errors:


enum NetworkError: Error {
    // Swift 3 dictates that enum cases should be `lowerCamelCase`
    case offline
    case serverError(String)
}

//An error indicates a non-fatal failure during program execution, and is handled with the specialized control-flow constructs do/catch, throw, and try.

func fetchResource(resource: NSURL) throws -> String {
//    if let (statusCode, responseString) = /* ...from elsewhere...*/ {
//        if case 500..<600 = statusCode {
//            throw NetworkError.serverError(responseString)
//        } else {
//            return responseString
            return ""
//        }
//    } else {
//        throw NetworkError.offline
//    }
}



//Errors can be caught with do/catch:
let resURL = NSURL.init(string: "http://ggg.vv")!
do {
    let response = try fetchResource(resource: resURL)
    // If fetchResource() didn't throw an error, execution continues here:
    print("Got response: \(response)")
    
} catch {
    // If an error is thrown, we can handle it here.
    print("Whoops, couldn't fetch resource: \(error)")
}
//Any function which can throw an error must be called using try, try?, or try!:

// error: call can throw but is not marked with 'try'
//let response = fetchResource(resource: resURL)

// "try" works within do/catch, or within another throwing function:
do {
    let response = try fetchResource(resource: resURL)
} catch {
    // Handle the error
}

func foo() throws {
    // If an error is thrown, continue passing it up to the caller.
    let response = try fetchResource(resource: resURL)
}

// "try?" wraps the function's return value in an Optional (nil if an error was thrown).
if let response = try? fetchResource(resource: resURL) {
    // no error was thrown
}

// "try!" crashes the program at runtime if an error occurs.
let response = try! fetchResource(resource: resURL)






enum CustomError: Error {
    case someError
    case anotherError
}

func throwing() throws {
    throw CustomError.someError
}



//The Do-Catch syntax allows to catch a thrown error, and automatically creates a constant named error available in the catch block:

do {
    try throwing()
} catch {
    print(error)
}

//You can also declare a variable yourself:

//It's also possible to chain different catch statements. This is convenient if several types of errors can be thrown in the Do block.

//Here the Do-Catch will first attempt to cast the error as a CustomError, then as an NSError if the custom type was not matched.


do {
    try throwing()
} catch let custom as CustomError {
    print(custom)
} catch {
    print(error)
}

//Catch and Switch Pattern for Explicit Error Handling
class Plane {
    
    enum Emergency: Error {
        case NoFuel
        case EngineFailure(reason: String)
        case DamagedWing
    }
    
    var fuelInKilograms: Int = 0
    
    //... init and other methods not shown
    
    func fly() throws {
        // ...
        if fuelInKilograms <= 0 {
            // uh oh...
            throw Emergency.NoFuel
        }
    }
    
}
//In the client class:

let airforceOne = Plane()
do {
    try airforceOne.fly()
} catch let emergency as Plane.Emergency {
    switch emergency {
    case .NoFuel: break
    // call nearest airport for emergency landing
    case .EngineFailure(let reason):
        print(reason) // let the mechanic know the reason
    case .DamagedWing: break
        // Assess the damage and determine if the president can make it
    }
}



//Create custom Error with localized description

//Create enum of custom errors

enum RegistrationError: Error {
    case invalidEmail
    case invalidPassword
    case invalidPhoneNumber
}
//Create extension of RegistrationError to handle the Localized description.

extension RegistrationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Description of invalid email address", comment: "Invalid Email")
        case .invalidPassword:
            return NSLocalizedString("Description of invalid password", comment: "Invalid Password")
        case .invalidPhoneNumber:
            return NSLocalizedString("Description of invalid phoneNumber", comment: "Invalid Phone Number")
        }
    }
}
//Handle error

let error: Error = RegistrationError.invalidEmail
print(error.localizedDescription)


//Disabling Error Propagation
//Use try! if you are sure there is no chance of error being thrown // doubt : "try" works within do/catch, or within another throwing function:

//---------------------Numbers------------------

//Number types and literals

//Swift's built-in numeric types are:

//Word-sized (architecture-dependent) signed Int and unsigned UInt.
//Fixed-size signed integers Int8, Int16, Int32, Int64, and unsigned integers UInt8, UInt16, UInt32, UInt64.
//Floating-point types Float32/Float, Float64/Double, and Float80 (x86-only).

//Floating-point literal syntax

let decimal = 0.0
let decimal1 = -42.0123456789
let decimal2 = 1_000.234_567_89

let decimal3 = 4.567e5               // equivalent to 4.567×10⁵, or 456_700.0
let decimal4 = -2E-4                 // equivalent to -2×10⁻⁴, or -0.0002
let decimal5 = 1e+0                  // equivalent to 1×10⁰, or 1.0

let hexadecimal1 = 0x1p0             // equivalent to 1×2⁰, or 1.0
let hexadecimal2 = 0x1p-2            // equivalent to 1×2⁻², or 0.25
let hexadecimal3 = 0xFEEDp+3         // equivalent to 65261×2³, or 522088.0
let hexadecimal4 = 0x1234.5P4        // equivalent to 0x12345, or 74565.0
let hexadecimal5 = 0x123.45P8        // equivalent to 0x12345, or 74565.0
let hexadecimal6 = 0x12.345P12       // equivalent to 0x12345, or 74565.0
let hexadecimal7 = 0x1.2345P16       // equivalent to 0x12345, or 74565.0
let hexadecimal8 = 0x0.12345P20      // equivalent to 0x12345, or 74565.0


//Convert numbers to/from strings

//Use String initializers for converting numbers into strings:

String(1635999)                              // returns "1635999"
String(1635999, radix: 10)                   // returns "1635999"
String(1635999, radix: 2)                    // returns "110001111011010011111"
String(1635999, radix: 16)                   // returns "18f69f"


//Use initializers of numeric types to convert strings into numbers:
    
if let num1 = Int("42") {print("num1 = \(num1)") }                // num is 42
if let num2 = Int("Z2cF") {print("num2 = \(num2)") }              // returns nil (not a number)
if let num3 = Int("z2cf", radix: 36) { print("num3 = \(num3)") }   // num is 1635999
if let num4 = Int("Z2cF", radix: 36) { print("num4 = \(num4)")}   // num is 1635999
if let num5 = Int8("Z2cF", radix: 36) { print("num5 = \(num5)") }  // returns nil (too large for Int8)



round

//Rounds the value to the nearest whole number with x.5 rounding up (but note that -x.5 rounds down).

round(3.000) // 3
round(3.001) // 3
round(-3.500) // -4  *** careful here ***
round(-3.999) // -4
//ceil

//Rounds any number with a decimal value up to the next larger whole number.

ceil(3.000) // 3
ceil(3.001) // 4
ceil(3.999) // 4
ceil(-3.000) // -3
ceil(-3.001) // -3
ceil(-3.999) // -3


//floor

//Rounds any number with a decimal value down to the next smaller whole number

floor(3.000) // 3
floor(3.001) // 3
floor(3.999) // 3

floor(-3.000) // -3
floor(-3.001) // -4
floor(-3.999) // -4

//Int

//Converts a Double to an Int, dropping any decimal value.

Int(3.000) // 3
Int(3.001) // 3
Int(3.999) // 3

Int(-3.000) // -3
Int(-3.001) // -3
Int(-3.999) // -3


//round, ceil and floor handle both 64 and 32 bit architecture


//Integer initializers produce a runtime error if the value overflows or underflows:

//Int8(-129.0) // fatal error: floating point value cannot be converted to Int8 because it is less than Int8.min
//Int8(-129)   // crash: EXC_BAD_INSTRUCTION / SIGILL

//Float-to-integer conversion rounds values towards zero:

Int(-2.2)  // -2
Int(-1.9)  // -1
Int(-0.1)  //  0
Int(1.0)   //  1
Int(1.2)   //  1
Int(1.9)   //  1
Int(2.0)   //  2


//Integer-to-float conversion may be lossy:

Int(Float(1_000_000_000_000_000_000))  // 999999984306749440// why is that?



//Random number generation

//arc4random_uniform(someNumber: UInt32) -> UInt32

//This gives you random integers in the range 0 to someNumber - 1.

//The maximum value for UInt32 is 4,294,967,295 (that is, 2^32 - 1).

//Examples:

//Coin flip

let flip = arc4random_uniform(2) // 0 or 1
//Dice roll

let roll = arc4random_uniform(6) + 1 // 1...6
//Random day in October

let day = arc4random_uniform(31) + 1 // 1...31
//Random year in the 1990s

let year = 1990 + arc4random_uniform(10)
//General form:

//let number = min + arc4random_uniform(max - min + 1)
//where number, max, and min are UInt32.

//Notes

//There is a slight modulo bias with arc4random so arc4random_uniform is preferred.
//You can cast a UInt32 value to an Int but just beware of going out of range.






































