//STACK
//  - Similar to an array, but with limited functionality
//  - New elements are appended to the end of the stack

public struct Stack <T> {
    fileprivate var stack = [T]()
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    public var count: Int {
        return stack.count
    }
    //PUSH - Add a new element to the top of the stack
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    //POP - Remove and return the last element on the stack
    public mutating func pop() -> T? {
        return stack.popLast()
    }
    //PEEK - Return the last element of on the stack
    public func peek() -> T? {
        return stack.last
    }
}

var newStack = Stack<Int>()

newStack.push(10)
newStack.push(3)
newStack.push(57)

let poppedStack = newStack.pop()
let peek = newStack.peek()

newStack