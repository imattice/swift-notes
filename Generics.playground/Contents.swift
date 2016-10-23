//: Playground - noun: a place where people can play

import Foundation


func adderInt(x: Int, y: Int) -> Int {
    return x + y
}

func adderDouble(x: Double, y: Double) -> Double {
    return x + y
}

let intSum = adderInt(x: 1, y: 2)
let doubleSum = adderDouble(x: 4.0, y: 2.0)


//Arrays as Generics
//    - Swift arrays are generic types, meaning that they require a type parameter to be fully specified
//    - Arrays use type inference so you do not have to explicitly declare the type when instantiating an array with values;  for example, in the code below, Swift will infer the numbers array will contain Ints based on its contents
//    - The contents of the numbersAgain array are explicity declared as Ints.  You cannot add a vaule of another type, such as String
let numbers = [1, 2, 3]
let firstNumber = numbers[0]

var numbersAgain = Array<Int>()
    numbersAgain.append(4)
    numbersAgain.append(5)
    numbersAgain.append(6)
let firstNumberAgain = numbersAgain[0]

//Cannot convert value of type 'String' to expected argument type 'Int'
//numbersAgain.append("Hello")





//OTHER GENERIC TYPES

let countryCodes = ["Austria" : "AT", "United States of America" : "US", "Turkey" : "TR"]
let at = countryCodes["Austria"]

let optionalName = Optional<String>.some("John")
if let name = optionalName {
}




//GENERIC FUNCTIONS
func pairsFromDictionary<KeyType, ValueType>(dictionary: [KeyType: ValueType]) -> [(KeyType, ValueType)] {
    return Array(dictionary)
}
let stringKeysIntValues = pairsFromDictionary(dictionary: ["minimmum" : 199, "maximum" : 299])
let intKeysStringValues = pairsFromDictionary(dictionary: [1 : "Swift", 2 : "Generics", 3 : "Rule"])





//GENERIC DATA STRUCTURES

struct Queue<Element> {
    private var elements = [Element]()

    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.remove(at: 0)
    }
}

var q = Queue<Int>()

q.enqueue(newElement: 4)
q.enqueue(newElement: 2)

q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()

//q.enqueue(newElement: "Hello")




//TYPE CONSTRAINTS AND WHERE CLAUSES
//  - You can use generics to specify if a type conforms to a specific protocol

func mid<T>(array: [T]) -> T where T: Comparable {
    return array.sorted()[(array.count - 1) / 2]
}

mid(array: [3, 5, 1, 2, 4])

protocol Summable { static func +(lhs: Self, rhs: Self) -> Self }

extension Int: Summable {}
extension Double: Summable {}

func adder<T: Summable>(x: T, y: T) -> T {
    return x + y
}

let adderIntSum = adder(x: 1, y: 4)
let adderDoubleSum = adder(x: 4.0, y: 9.0)

extension String: Summable {}
let adderString = adder(x: "Generics", y: " are Awesome!")















































