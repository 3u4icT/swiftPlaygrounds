//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//--------------------Design Patterns - Creational-------------------------------//


//Creational design patterns abstract the instantiation of objects to make a system more independent of the process of creation, composition, and representation.


//Singleton



//Singletons are a frequently used design pattern which consists of a single instance of a class that is shared throughout a program.

//In the following example, we create a static property that holds an instance of the Foo class. Remember that a static property is shared between all objects of a class and can't be overwritten by subclassing.

public class Foo
{
    static let shared = Foo()
    
    // Used for preventing the class from being instantiated directly
    private init() {}
    
    func doSomething()
    {
        print("Do something")
    }
}

Foo.shared.doSomething()

//Builder pattern
//The main goal of the builder pattern is to setup a default configuration for an object from its creation. It is an intermediary between the object will be built and all other objects related to building it.


enum CarType {
    case
    
    sportage,
    saloon
}

enum GearType {
    case
    
    manual,
    automatic
}

struct Motor {
    var id: String
    var name: String
    var model: String
    var numberOfCylinders: UInt8
}

class Car: CustomStringConvertible {
    var color: UIColor
    var numberOfSeats: UInt8
    var numberOfWheels: UInt8
    var type: CarType
    var gearType: GearType
    var motor: Motor
    var shouldHasAirbags: Bool
    
    var description: String {
        return "color: \(color)\nNumber of seats: \(numberOfSeats)\nNumber of Wheels: \(numberOfWheels)\n Type: \(gearType)\nMotor: \(motor)\nAirbag Availability: \(shouldHasAirbags)"
    }
    
    init(color: UIColor, numberOfSeats: UInt8, numberOfWheels: UInt8, type: CarType, gearType: GearType, motor: Motor, shouldHasAirbags: Bool) {
        
        self.color = color
        self.numberOfSeats = numberOfSeats
        self.numberOfWheels = numberOfWheels
        self.type = type
        self.gearType = gearType
        self.motor = motor
        self.shouldHasAirbags = shouldHasAirbags
        
    }
}


//Creating a car object:

let aCar = Car(color: UIColor.black,
               numberOfSeats: 4,
               numberOfWheels: 4,
               type: .saloon,
               gearType: .automatic,
               motor: Motor(id: "101", name: "Super Motor",
                            model: "c4", numberOfCylinders: 6),
               shouldHasAirbags: true)

print(aCar)

/* Printing
 color: UIExtendedGrayColorSpace 0 1
 Number of seats: 4
 Number of Wheels: 4
 Type: automatic
 Motor: Motor(id: "101", name: "Super Motor", model: "c4", numberOfCylinders: 6)
 Airbag Availability: true
 */


//The problem arises when creating a car object is that the car requires many configuration data to be created.

//For applying the Builder Pattern, the initializer parameters should have default values which are changeable if needed.

//CarBuilder class:

class CarBuilder {
    var color: UIColor = UIColor.black
    var numberOfSeats: UInt8 = 5
    var numberOfWheels: UInt8 = 4
    var type: CarType = .saloon
    var gearType: GearType = .automatic
    var motor: Motor = Motor(id: "111", name: "Default Motor",
                             model: "T9", numberOfCylinders: 4)
    var shouldHasAirbags: Bool = false
    
    func buildCar() -> Car {
        return Car(color: color, numberOfSeats: numberOfSeats, numberOfWheels: numberOfWheels, type: type, gearType: gearType, motor: motor, shouldHasAirbags: shouldHasAirbags)
    }
}


//The CarBuilder class defines properties that could be changed to to edit the values of the created car object.

//Let's build new cars by using the CarBuilder

var builder = CarBuilder()
// currently, the builder creates cars with default configuration.

let defaultCar = builder.buildCar()
//print(defaultCar.description)
/* prints
 color: UIExtendedGrayColorSpace 0 1
 Number of seats: 5
 Number of Wheels: 4
 Type: automatic
 Motor: Motor(id: "111", name: "Default Motor", model: "T9", numberOfCylinders: 4)
 Airbag Availability: false
 */

builder.shouldHasAirbags = true
// now, the builder creates cars with default configuration,
// but with a small edit on making the airbags available

let safeCar = builder.buildCar()
print(safeCar.description)
/* prints
 color: UIExtendedGrayColorSpace 0 1
 Number of seats: 5
 Number of Wheels: 4
 Type: automatic
 Motor: Motor(id: "111", name: "Default Motor", model: "T9", numberOfCylinders: 4)
 Airbag Availability: true
 */

builder.color = UIColor.purple
// now, the builder creates cars with default configuration
// with some extra features: the airbags are available and the color is purple

let femaleCar = builder.buildCar()
print(femaleCar)
/* prints
 color: UIExtendedSRGBColorSpace 0.5 0 0.5 1
 Number of seats: 5
 Number of Wheels: 4
 Type: automatic
 Motor: Motor(id: "111", name: "Default Motor", model: "T9", numberOfCylinders: 4)
 Airbag Availability: true
 */


//The benefit of applying the Builder Pattern is the ease of creating objects that should contain much of configurations by setting default values, also, the ease of changing these default values.

//Take it Further:

//As a good practice, all properties that need default values should be in a separated protocol, which should be implemented by the class itself and its builder.

//Backing to our example, let's create a new protocol called CarBluePrint:


protocol CarBluePrint {
    var color: UIColor { get set }
    var numberOfSeats: UInt8 { get set }
    var numberOfWheels: UInt8 { get set }
    var type: CarType { get set }
    var gearType: GearType { get set }
    var motor: Motor { get set }
    var shouldHasAirbags: Bool { get set }
}

class Car1: CustomStringConvertible, CarBluePrint {
    var color: UIColor
    var numberOfSeats: UInt8
    var numberOfWheels: UInt8
    var type: CarType
    var gearType: GearType
    var motor: Motor
    var shouldHasAirbags: Bool
    
    var description: String {
        return "color: \(color)\nNumber of seats: \(numberOfSeats)\nNumber of Wheels: \(numberOfWheels)\n Type: \(gearType)\nMotor: \(motor)\nAirbag Availability: \(shouldHasAirbags)"
    }
    
    init(color: UIColor, numberOfSeats: UInt8, numberOfWheels: UInt8, type: CarType, gearType: GearType, motor: Motor, shouldHasAirbags: Bool) {
        
        self.color = color
        self.numberOfSeats = numberOfSeats
        self.numberOfWheels = numberOfWheels
        self.type = type
        self.gearType = gearType
        self.motor = motor
        self.shouldHasAirbags = shouldHasAirbags
        
    }
}

class CarBuilder1: CarBluePrint {
    var color: UIColor = UIColor.black
    var numberOfSeats: UInt8 = 5
    var numberOfWheels: UInt8 = 4
    var type: CarType = .saloon
    var gearType: GearType = .automatic
    var motor: Motor = Motor(id: "111", name: "Default Motor",
                             model: "T9", numberOfCylinders: 4)
    var shouldHasAirbags: Bool = false
    
    func buildCar() -> Car {
        return Car(color: color, numberOfSeats: numberOfSeats, numberOfWheels: numberOfWheels, type: type, gearType: gearType, motor: motor, shouldHasAirbags: shouldHasAirbags)
    }
}


//The benefit of declaring the properties that need default value into a protocol is the forcing to implement any new added property; When a class conforms to a protocol, it has to declare all its properties/methods.


//Factory Pattern


//In class-based programming, the factory method pattern is a creational pattern that uses factory methods to deal with the problem of creating objects without having to specify the exact class of the object that will be created



protocol SenderProtocol
{
    func send(package: AnyObject)
}

class Fedex: SenderProtocol
{
    func send(package: AnyObject)
    {
        print("Fedex deliver")
    }
}

class RegularPriorityMail: SenderProtocol
{
    func send(package: AnyObject)
    {
        print("Regular Priority Mail deliver")
    }
}

// This is our Factory
class DeliverFactory
{
    // It will be responsable for returning the proper instance that will handle the task
    static func makeSender(isLate isLate: Bool) -> SenderProtocol
    {
        return isLate ? Fedex() : RegularPriorityMail()
    }
}

// Usage:
let package = ["Item 1", "Item 2"]

// Fedex class will handle the delivery
DeliverFactory.makeSender(isLate:true).send(package: package as AnyObject)

// Regular Priority Mail class will handle the delivery
DeliverFactory.makeSender(isLate:false).send(package: package as AnyObject)


//By doing that we don't depend on the real implementation of the class, making the sender() completely transparent to who is consuming it.

//In this case all we need to know is that a sender will handle the deliver and exposes a method called send(). There are several other advantages: reduce classes coupling, easier to test, easier to add new behaviours without having to change who is consuming it


//Chain of Responsibility

//In object-oriented design, the chain-of-responsibility pattern is a design pattern consisting of a source of command objects and a series of processing objects. Each processing object contains logic that defines the types of command objects that it can handle; the rest are passed to the next processing object in the chain. A mechanism also exists for adding new processing objects to the end of this chain.


//Chain of responsibility
//http://stackoverflow.com/documentation/swift/4941/design-patterns-creational/26459/chain-of-responsibility#t=201704261011515820778
//Not clear


//Iterator

struct Turtle {
    let name: String
}

struct Turtles {
    let turtles: [Turtle]
}

struct TurtlesIterator: IteratorProtocol {
    private var current = 0
    private let turtles: [Turtle]
    
    init(turtles: [Turtle]) {
        self.turtles = turtles
    }
    
    mutating func next() -> Turtle? {
        defer { current += 1 }
        return turtles.count > current ? turtles[current] : nil
    }
}

extension Turtles: Sequence {
    func makeIterator() -> TurtlesIterator {
        return TurtlesIterator(turtles: turtles)
    }
}

let ninjaTurtles = Turtles(turtles: [Turtle(name: "Leo"),
                                     Turtle(name: "Mickey"),
                                     Turtle(name: "Raph"),
                                     Turtle(name: "Doney")])
print("Splinter and")
for turtle in ninjaTurtles {
    print("The great: \(turtle)")
}


//Observer

//The observer pattern is where an object, called the subject, maintains a list of its dependents, called observers, and notifies them automatically of any state changes, usually by calling one of their methods. It is mainly used to implement distributed event handling systems. The Observer pattern is also a key part in the familiar model–view–controller (MVC) architectural pattern

//Basically the observer pattern is used when you have an object which can notify observers of certain behaviors or state changes

//Explains NSNotification center

//------------------------------Conditionals-----------------------//

//Optionals must be unwrapped before they can be used in most expressions. if let is an optional binding, which succeeds if the optional value was not nil

let num: Int? = 10 // or: let num: Int? = nil

if let unwrappedNum = num {
    // num has type Int?; unwrappedNum has type Int
    print("num was not nil: \(unwrappedNum + 1)")
} else {
    print("num was nil")
}

//In Swift 3, where clauses have been replaced (SE-0099): simply use another , to separate optional bindings and boolean conditions.

if let unwrappedNum = num, unwrappedNum % 2 == 0 {
    print("num is non-nil, and it's an even number")
}
let str1 : String? = "hetagad"
if let num = num,                           // num must be non-nil
    num % 2 == 1,                           // num must be odd
    let str = str1,                          // str1 must be non-nil
    let firstChar = str.characters.first,   // str must also be non-empty
    firstChar != "x"                        // the first character must not be "x"
{
    // all bindings & conditions succeeded!
}


//Using guard



//Guard checks for a condition, and if it is false, it enters the branch. Guard check branches must leave its enclosing block either via return, break, or continue (if applicable); failing to do so results in a compiler error. This has the advantage that when a guard is written it's not possible to let the flow continue accidentally (as would be possible with an if).

func printNum(num: Int) {
    guard num == 10 else {
        print("num is not 10")
        return
    }
    print("num is 10")
}
//Guard can also check if there is a value in an optional, and then unwrap it in the outer scope:

func printOptionalNum(num: Int?) {
    guard let unwrappedNum = num else {
        print("num does not exist")
        return
    }
    print(unwrappedNum)
}
//Guard can combine optional unwrapping and condition check using where keyword:

func printOptionalNum1(num: Int?) {
    guard let unwrappedNum = num, unwrappedNum == 10 else {
        print("num does not exist or is not 10")
        return
    }
    print(unwrappedNum)
}
printOptionalNum1(num: 10)



//Basic conditionals: if-statements
let num2 = 10
let str2 = "Hi"
if num2 == 10 && str2 == "Hi" {
    print("num is 10, AND str is \"Hi\"")
}
//If num == 10 was false, the second value wouldn't be evaluated. This is known as short-circuit evaluation.

//The logical OR operator

if num2 == 10 || str2 == "Hi" {
    print("num is 10, or str is \"Hi\"")
}
//If num == 10 is true, the second value wouldn't be evaluated.

//The logical NOT operator

if !str.isEmpty {
    print("str is not empty")
}


//Ternary operator

//The ternary conditional operator takes a condition and returns one of two values, depending on whether the condition was true or false. The syntax is as follows: This is equivalent of having the expression:

//(<CONDITION>) ? <TRUE VALUE> : <FALSE VALUE>

let a = 5
let b = 10
let min = a < b ? a : b
let max = a > b ? a : b


//Switch Statements

//------------------------------Loops---------------------//

//For-in loop


//The for-in loop allows you to iterate over any sequence.

//Iterating over a range

//You can iterate over both half-open and closed ranges
for i in 0..<3 {
    print(i)
}

for i in 0...2 {
    print(i)
}


let names = ["James", "Emily", "Miles"]

for (index, name) in names.enumerated() {
    print("The index of \(name) is \(index).")
}

//Iterating over a dictionary
let ages = ["James": 29, "Emily": 24]

for (name, age) in ages {
    print(name, "is", age, "years old.")
}


//iterating in reverse
for i in (0..<3).reversed() {
    print(i)
}


for i in stride(from: 4, to: 0, by: -2) {
    print(i)
}

//Repeat-while loop

//Similar to the while loop, only the control statement is evaluated after the loop. Therefore, the loop will always execute at least once
var i: Int = 0

repeat {
    print("while \(i)")
    i += 1
} while i < 3

//By adding a where clause you can restrict the iterations to ones that satisfy the given condition.

for i in 0..<5 where i % 2 == 0 {
    print(i)
}


//case clause
//It's useful when you need to iterate only through the values that match some pattern

let points = [(5, 0), (31, 0), (5, 31)]
for case (_, 0) in points {
    print("point on x-axis")
}


//Also you can filter optional values and unwrap them if appropriate by adding ? mark after binding constant

let optionalNumbers = [31, 5, nil]
for case let number? in optionalNumbers {
    print(number)
}

//ForEach block
//Note: Control flow statements (such as break or continue) may not be used in these blocks. A return can be called, and if called, will immediately return the block for the current iteration (much like a continue would). The next iteration will then execute.

let arr = [1,2,3,4]

arr.forEach {
    
    // blocks for 3 and 4 will still be called
    if $0 == 2 {
        return
    }
}


//while loop


//A while loop will execute as long as the condition is true.

var count = 1

while count < 10 {
    print("This is the \(count) run of the loop")
    count += 1
}

//Obtaining a Grand Central Dispatch (GCD) queue

//Grand Central Dispatch works on the concept of "Dispatch Queues". A dispatch queue executes tasks you designate in the order which they are passed. There are three types of dispatch queues:
//
//Serial Dispatch Queues (aka private dispatch queues) execute one task at a time, in order. They are frequently used to synchronize access to a resource.
//Concurrent Dispatch Queues (aka global dispatch queues) execute one or more tasks concurrently.
//The Main Dispatch Queue executes tasks on the main thread


let mainQueue = DispatchQueue.main

//The system provides concurrent global dispatch queues (global to your application), with varying priorities. You can access these queues using the DispatchQueue class in Swift 3

let globalConcurrentQueue = DispatchQueue.global(qos: .default)

//In iOS 8 or later, the possible quality of service values which may be passed are .userInteractive, .userInitiated, .default, .utility, and .background. These replace the DISPATCH_QUEUE_PRIORITY_ constants

let myConcurrentQueue = DispatchQueue(label: "my-concurrent-queue", qos: .userInitiated, attributes: [.concurrent], autoreleaseFrequency: .workItem, target: nil)
let mySerialQueue = DispatchQueue(label: "my-serial-queue", qos: .background, attributes: [], autoreleaseFrequency: .workItem, target: nil)

//In Swift 3, queues created with this initializer are serial by default, and passing .workItem for autorelease frequency ensures an autorelease pool is created and drained for each work item. There is also .never, which means you will be managing your own autorelease pools yourself, or .inherit which inherits the setting from the environment. In most cases you probably won't use .never except in cases of extreme customization.


//Concurrent Loops

//GCD provides mechanism for performing a loop, whereby the loops happen concurrently with respect to each other. This is very useful when performing a series of computationally expensive calculations

//DispatchQueue.concurrentPerform(iterations: iterations) { index in
//    // Do something computationally expensive here
//}


//The loop closure will be invoked for each index from 0 to, but not including, iterations. These iterations will be run concurrently with respect to each other, and thus the order that they run is not guaranteed. The actual number of iterations that happen concurrently at any given time is generally dictated by the capabilities of the device in question (e.g. how many cores does the device have).

//A couple of special considerations:

//The concurrentPerform/dispatch_apply may run the loops concurrently with respect to each other, but this all happens synchronously with respect to the thread from which you call it. So, do not call this from the main thread, as this will block that thread until the loop is done.

//Because these loops happen concurrently with respect to each other, you are responsible for ensuring the thread-safety of the results. For example, if updating some dictionary with the results of these computationally expensive calculations, make sure to synchronize those updates yourself.

//Note, there is some overhead associated in running concurrent loops. Thus, if the calculations being performed inside the loop are not sufficiently computationally intensive, you may find that any performance gained by using concurrent loops may be diminished, if not be completely offset, by the overhead associated with the synchronizing all of these concurrent threads.

//So, you are responsible determining the correct amount of work to be performed in each iteration of the loop. If the calculations are too simple, you may employ "striding" to include more work per loop. For example, rather than doing a concurrent loop with 1 million trivial calculations, you may do 100 iterations in your loop, doing 10,000 calculations per loop. That way there is enough work being performed on each thread, so the overhead associated with managing these concurrent loops becomes less significant.



//Running tasks in a Grand Central Dispatch (GCD) queue

//To run tasks on a dispatch queue, use the sync, async, and after methods.

//To dispatch a task to a queue asynchronously:

let queue = DispatchQueue(label: "myQueueName")

queue.async {
    //do something
    
    DispatchQueue.main.async {
        //this will be called in main thread
        //any UI updates should be placed here
    }
}
// ... code here will execute immediately, before the task finished
//To dispatch a task to a queue synchronously:

queue.sync {
    // Do some task
}
// ... code here will not execute until the task is finished
//To dispatch a task to a queue after a certain number of seconds:

queue.asyncAfter(deadline: .now() + 3) {
    //this will be executed in a background-thread after 3 seconds
}
// ... code here will execute immediately, before the task finished


//Running Tasks in an OperationQueue

//You can think of an OperationQueue as a line of tasks waiting to be executed. Unlike dispatch queues in GCD, operation queues are not FIFO (first-in-first-out). Instead, they execute tasks as soon as they are ready to be executed, as long as there are enough system resources to allow for it.

let mainQueue1 = OperationQueue.main

//Create a custom OperationQueue:

let queue1 = OperationQueue()
queue1.name = "My Queue"
queue1.qualityOfService = .default


//Quality of Service specifies the importance of the work, or how much the user is likely to be counting on immediate results from the task

// An instance of some Operation subclass
let operation = BlockOperation {
    // perform task here
}

//queue.addOperation(operation)

//Add a block to an OperationQueue:


queue1.addOperation {
    // some task
}
//Add multiple Operations to an OperationQueue:

let operations = [Operation]()
// Fill array with Operations

//queue1.addOperation(operations)
//Adjust how many Operations may be run concurrently within the queue:

queue1.maxConcurrentOperationCount = 3 // 3 operations may execute at once

// Sets number of concurrent operations based on current system conditions
queue1.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
//Suspending a queue will prevent it from starting the execution of any existing, unstarted operations or of any new operations added to the queue. The way to resume this queue is to set the isSuspended back to false:


queue1.isSuspended = true

// Re-enable execution
queue1.isSuspended = false
//Suspending an OperationQueue does not stop or cancel operations that are already executing. One should only attempt suspending a queue that you created, not global queues or the main queue.


//Creating High-Level Operations

//The Foundation framework provides the Operation type, which represents a high-level object that encapsulates a portion of work that may be executed on a queue. Not only does the queue coordinate the performance of those operations, but you can also establish dependencies between operations, create cancelable operations, constrain the degree of concurrency employed by the operation queue, etc.

//Operations become ready to execute when all of its dependencies are finished executing. The isReady property then changes to true.

//Create a simple non-concurrent Operation subclass:


//class MyOperation: Operation {
//    
//    init(<parameters>) {
//        // Do any setup work here
//    }
//    
//    override func main() {
//        // Perform the task
//    }
//    
//}

//Add an operation to an OperationQueue:


//myQueue1.addOperation(operation)
//This will execute the operation concurrently on the queue.

//Manage dependencies on an Operation.

//Dependencies define other Operations that must execute on a queue before that Operation is considered ready to execute.


//operation2.addDependency(operation1)

//operation2.removeDependency(operation1)
//Run an Operation without a queue:

operation.start()
//Dependencies will be ignored. If this is a concurrent operation, the task may still be executed concurrently if its start method offloads work to background queues.

//Concurrent Operations.

//If the task that an Operation is to perform is, itself, asynchronous, (e.g. a URLSession data task), you should implement the Operation as a concurrent operation. In this case, your isAsynchronous implementation should return true, you'd generally have start method that performs some setup, then calls its main method which actually executes the task.

//When implementing an asynchronous Operation begins you must implement isExecuting, isFinished methods and KVO. So, when execution starts, isExecuting property changes to true. When an Operation finishes its task, isExecuting is set to false, and isFinished is set to true. If the operation it is cancelled both isCancelled and isFinished change to true. All of these properties are key-value observable.

//Cancel an Operation.

//Calling cancel simply changes the isCancelled property to true. To respond to cancellation from within your own Operation subclass, you should check the value of isCancelled at least periodically within main and respond appropriately.

operation.cancel()






















