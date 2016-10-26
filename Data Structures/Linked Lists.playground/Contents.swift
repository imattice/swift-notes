//LINKED LISTS
//  - Similar to an array, but unlike how an array allocates a block of memory for the objects, the linked lists are totally separate and are connected through links
//  - The elements in a linked list are referred to as nodes.  Each node has a reference, or pointer, to the next node
//  - A doubly linked list also have pointers to the previous node≥
//  - The order of the list is important, starting at the head and ending with the tail.  The "next" pointer of the last node is nil, as is the previous pointer on the head node
//  - Most operations on a linked list are slower than those on an array.  The time intensive part is finding the correct object, as you cannot simply refer to the index.  You have to start at the head (or tail) and navigate through the links to that specific node.  However, operations like insertion and deletion are very fast.
//      - Therefore, when working with a linked list, you should insert new items at the front.
//  - Singly linked lists use slightly less memory than doubly linked lists because they do not need to store references to the previous node.  However, you cannot access a previous node without returning to the head and navigating through the links again.  Oftentimes, doubly linked lists make things easier.

public class DoubleLinkedListNode<T> {
    var value: T
    var next: DoubleLinkedListNode?
    weak var previous: DoubleLinkedListNode?
    //one of the pointers is weak as to avoid and ownership cycle if a node is deleted. If nodeA points to nodeB, but nodeB also points to nodeA, deleting nodeA would still reserve memory, since nodeB maintains a reference to it.
    
    public init(value: T) {
        self.value = value
    }
}
public class LinkedList<T> {
    public typealias Node = DoubleLinkedListNode<T>
    
    private var head: Node?
    
    private var isEmpty: Bool {
        return head == nil 
    }
    
    public var first: Node? {
        return head
    }
}
