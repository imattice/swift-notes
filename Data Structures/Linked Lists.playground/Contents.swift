//LINKED LISTS
//  - Similar to an array, but unlike how an array allocates a block of memory for the objects, the linked lists are totally separate and are connected through links
//  - The elements in a linked list are referred to as nodes.  Each node has a reference, or pointer, to the next node
//  - A doubly linked list also have pointers to the previous node≥
//  - The order of the list is important, starting at the head and ending with the tail.  The "next" pointer of the last node is nil, as is the previous pointer on the head node
//  - Most operations on a linked list are slower than those on an array.  The time intensive part is finding the correct object, as you cannot simply refer to the index.  You have to start at the head (or tail) and navigate through the links to that specific node.  However, operations like insertion and deletion are very fast.
//      - Therefore, when working with a linked list, you should insert new items at the front.
//  - Singly linked lists use slightly less memory than doubly linked lists because they do not need to store references to the previous node.  However, you cannot access a previous node without returning to the head and navigating through the links again.  Oftentimes, doubly linked lists make things easier.
//  - When performing operations on a linked list, you have to be sure to keep track and update the next and previous pointers, as well as possibly the head and tail.  If this gets messed up, the program will crash at some point
//  - When processing lists, you can often use recursion, processing the first element and then repeatedly calling the function on the rest of the list, finsihsing when there is no next element.  Linked lists are the foundation of functional programming languages such as LISP.

public class DoubleLinkedListNode<T> {
    var value: T
    var next: DoubleLinkedListNode?
    weak var previous: DoubleLinkedListNode?
    //one of the pointers is weak as to avoid and ownership cycle if a node is deleted. If nodeA points to nodeB, but nodeB also points to nodeA, deleting nodeA would still reserve memory, since nodeB maintains a reference to it.
    
    public init(value: T) {
        self.value = value
    }
}
public class DoubleLinkedList<T> {
    public typealias Node = DoubleLinkedListNode<T>
    
//  1a. create core properties of the linked list
    public var head: Node?
    
    public var isEmpty: Bool {
        return head == nil 
    }
    
    public var first: Node? {
        return head
    }
    public var last: Node? {
        // this is an expensive operation, particularly if the list is long
        if var node = head {
            //continue down the list until node.next is nil
            while case let next? = node.next {
                node = next 
            }
            return node 
        } else {
            return nil
        }
    }
    
//  2a. add a new node to the list
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }

//  3a. return a total of the existing nodes
//    - one way to speed this up would be to keep track of a variable and increment/decrement whenever a node is added or removed
    public var count: Int {
        if var node = head {
            var c = 1
            while case let next? = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
    }
//  3b. find the node at a specific index
    public func nodeAt(_ index: Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        return nil 
    }
//  3c. add a subscript to replace the public nodeAt function
    public subscript(index: Int) -> T {
        let node = nodeAt(index)
        assert(node != nil)
        return node!.value
    }
    
//  4.  the previous code appends a node to the end of the list, which is slow because you need to find the end first.  You can append nodes to the front of the list to avoid this
//  4a. define a helper function to find the nodes before and after a specific node
    private func nodesBeforeAndAfter(index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = head
        var prev: Node?
        
        while next != nil && i > 0 {
            i -= 1
            prev = next
            next = next!.next
        }
        assert(i == 0)
        return (prev, next)
    }
//  4b. insert a node
    public func insert(value: T, atIndex index: Int) {
        // find the nodes in the list that will be before and after the new node.  Note that prev can be nil if index is the head, next can be nil if index is the end of the list, and both can be nil if the list is empty
        let (prev, next) = nodesBeforeAndAfter(index: index)
        
        // create a new node and connect to the prev and next pointers.  You only set them if they are not nil.
        let newNode = Node(value: value)
            newNode.previous = prev
            newNode.next = next
            prev?.next = newNode
            next?.previous = newNode
        
        // if the new node is placed at the front of the list, update the list head pointer.  If you had a tail pointer, then you would also add that.
        if prev == nil {
            head = newNode
        }
    }
//  5a. remove all nodes
    public func removeAll() {
        head = nil
    }
//  5b. remove a single node
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next 
        } else {
            head = next 
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
//  5c. remove the last node
        // for a singly linked list, removing the last node is complicated because you need that reference to the previous node.  Instead, you could use the nodesBeforeAndAfter.  You can use a tail pointer, removing that tail and setting the new tail pointer to the previous node
    public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
//  5d. remove at a given index
    public func removeAt(_ index: Int) -> T {
        let node = nodeAt(index)
        assert(node != nil)
        return remove(node: node!)
    }
//  6a. reverse the direction of the nodes
    public func reverse() {
        var node = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
//  7a. add map function
    public func map<U>(transform: (T) -> U) -> DoubleLinkedList<U> {
        let result = DoubleLinkedList<U>()
        var node = head
        while node != nil {
            result.append(value: transform(node!.value))
            node = node!.next
        }
        return result
    }
//  7b. add a filter function
    public func filter(predicate: (T) -> Bool) -> DoubleLinkedList<T> {
        let result = DoubleLinkedList<T>()
        var node = head
        
        while node != nil {
            if predicate(node!.value) {
                result.append(value: node!.value)
            }
            node = node!.next
        }
        return result
    }
}

// Add an extension that makes the output human-readable
extension DoubleLinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
}


//  l)
let doubleLinkedList = DoubleLinkedList<String>()
    doubleLinkedList.isEmpty
    doubleLinkedList.first

//  2)
    // add a new value
    doubleLinkedList.append(value: "Hello")
    doubleLinkedList.isEmpty
    doubleLinkedList.first!.value
    doubleLinkedList.last!.value
    
    // add another value
    doubleLinkedList.append(value: "World")
    doubleLinkedList.first!.value
    doubleLinkedList.last!.value

    // the linked list now has links between the nodes with first and last nodes returning nil when pointing beyond the list
    doubleLinkedList.first!.previous
    doubleLinkedList.first!.next?.value
    doubleLinkedList.last?.previous?.value
    doubleLinkedList.last?.next

//  3)
    //  look at values using a specific index
    doubleLinkedList.nodeAt(0)?.value
    doubleLinkedList.nodeAt(1)?.value
    doubleLinkedList.nodeAt(17)

    // use the subscript to look at these valuse
    doubleLinkedList[0]
    doubleLinkedList[1]
    //doubleLinkedList[17]  // will crash

//  4)
    // insert in the middle of the list
    doubleLinkedList.insert(value: "Swift", atIndex: 1)
    doubleLinkedList[0]
    doubleLinkedList[1]
    doubleLinkedList[2]
    
    // insert at the front of the list
    doubleLinkedList.insert(value: "Oh!", atIndex: 0)
    doubleLinkedList[0]
    doubleLinkedList[1]

    // insert at the end of the list
    doubleLinkedList.insert(value: "!", atIndex: doubleLinkedList.count)
    //count starts at 1, where indexes start at 0
    doubleLinkedList[doubleLinkedList.count - 2]
    doubleLinkedList[doubleLinkedList.count - 1]
    
//  5)
    // remove a node
    doubleLinkedList.count
    doubleLinkedList.remove(node: doubleLinkedList.first!)
    doubleLinkedList.count
    doubleLinkedList[0]

    // remove the last node
    doubleLinkedList.removeLast()
    doubleLinkedList.count
    doubleLinkedList[0]

    //remove at a specific index
    doubleLinkedList.removeAt(1)
    doubleLinkedList.count
    doubleLinkedList[0]
    doubleLinkedList[1]

// 6)
    // reverse the nodes
    doubleLinkedList.reverse()
    doubleLinkedList.reverse()

// 7)
    // map a list
let list = DoubleLinkedList<String>()
    list.append(value: "Hello")
    list.append(value: "Swifty")
    list.append(value: "Universe")

let map = list.map() { s in s.characters.count }
    map

    // filter a list
let filter = list.filter { s in s.characters.count > 5 }
    filter


// An alternative approach would be to use an enum instead of a class.  Classes use reference semantics, which make them heavier to use than other collection types like Arrays or Dicts
//    - This method results in a new copy of the list

enum ListNode<T> {
    indirect case Node(T, next: ListNode<T>)
    case End
}










































