//QUEUE
//    - A list where you insert items in the back and remove from the front.  First come, first serve.
//    - FIFO: First in, first out
//    - Often acts as a temporary list
//    - The reverse of the Stack
//    - Adding an element to the end of a queue always takes the same time and is inexpensive to do, as there are extra empty elements at the end of the array.  When an element is added to the queue, the only work being done is swapping the empty element for the newly added one
//    - Dequeueing, on the other hand, is expensive, as it must move all existing elements to fill the newly removed element.  For example, element[1] will now be moved to element[0] and so on until the end of the queue.
//        - To remove this drawback, you can replace the element[0] with an empty nil element instead of removing it, just like what happens at the end of the array.  Since these empty elements in the front will never be used, you can periodically whipe them from the array, which is expensive, but not as expensive as doing this each time an item is dequeued.  This has been done in the queue example below.


public struct Queue<T> {
    fileprivate var queue = [T?]()
    fileprivate var headNilElements = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    public var count: Int {
        return queue.count - headNilElements
    }
    //ENQUEUE - Add a new element to the back of the queue
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    //DEQUEUE - Remove an element from the front of the queue
    public mutating func dequeue() -> T? {
        guard headNilElements < queue.count, let element = queue[headNilElements] else { return nil }
        
        queue[headNilElements] = nil
        headNilElements += 1
        
        let percentage = Double(headNilElements)/Double(queue.count)
        if queue.count > 50 && percentage > 0.25 {
            queue.removeFirst(headNilElements)
            headNilElements = 0
        }
        return element
    }
    //PEEK - Return the first element in the queue
    public func peek() -> T? {
        if isEmpty {
            return nil
        } else {
            return queue[headNilElements]
        }
    }
}

var q = Queue<String>()
q.queue

q.enqueue("Buy Milk")
q.enqueue("Take out Trash")
q.enqueue("Mail letter")
q.enqueue("Do laundry")
q.queue
q.count

q.dequeue()
q.queue
q.count

q.dequeue()
q.queue
q.count

q.enqueue("Pay rent")
q.queue
q.count