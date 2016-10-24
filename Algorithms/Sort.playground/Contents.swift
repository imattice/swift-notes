//INSERTION SORT
//    - Take a group of unsorted numbers, and place them in an array, one by one, sorted.  For example, if 3 is the number to be added to the array [1, 4, 7, 10], it will be inserted at array[1] rather than added to the end and resorting the entire array
//    - One method is to move through the array and swap the position of the current number with the position of the next number, but only if that next number is smaller than the current number.  This splits the array into two sections: One section that is sorted and the rest of the array which remains unsorted.  This can be seen in insertionSortSwap()
//    - Another method is similar to the previous, but instead of mulitple swap calls, remember the number to be sorted, then replace each previous value until the previous value is the same or lower than the number to be sorted.  This can be seen in insertionSortShift()
//    - This method can also be used to sort things other than numbers by making the function generic and adding a comparision function.  This can be seen in insertionSort()
//    - Insertion Sort is considered a stable sort.  This means that elements with identical sort keys remain in the same order after sorting.  This is important for objects that might have the same 'priority' value
//    - Insertion Sort is very fast if the array is already sorted, which is not true for all search algorithms.  It is very fast at sorting small arrays.

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]


func insertionSortSwap(_ array: [Int]) -> [Int] {
    //make a copy of the array.  You cannot modify the contents of the array parameter directly
    var a = array
    //look at each element in the array, starting with the last element.  Variable "x" will be the first number in the unsorted portion of the array
    for x in 1..<a.count {
        print(x)
        var y = x
        //look at the current element in position x and compare it to the element imediately before it.  If a the previous number is larger, swap the position of the two elements
        while y > 0 && a[y] < a[y-1] {
            swap(&a[y - 1], &a[y])
            y -= 1
        }
    }
    return a
}

let swapSortedArray = insertionSortSwap(list)
swapSortedArray

func insertionSortShift(_ array: [Int]) -> [Int] {
    //make a copy of the array.  You cannot modify the contents of the array parameter directly
    var a = array
    //look at each element in the array, starting with the last element.  Variable "x" will be the first number in the unsorted portion of the array
    for x in 1..<a.count {
        print(x)
        var y = x
        //remember the number to be sorted
        let temp = a[y]
        while y > 0 && temp < a[y - 1] {
            a[y] = a[y-1]
            y -= 1
        }
        a[y] = temp
        
    }
    return a
}


let shiftSortedArray = insertionSortShift(list)
shiftSortedArray


func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    //make a copy of the array.  You cannot modify the contents of the array parameter directly
    var a = array
    //look at each element in the array, starting with the last element.  Variable "x" will be the first number in the unsorted portion of the array
    for x in 1..<a.count {
        print(x)
        var y = x
        //remember the number to be sorted
        let temp = a[y]
        while y > 0 && isOrderedBefore(temp, a[y - 1]) {
            a[y] = a[y-1]
            y -= 1
        }
        a[y] = temp
        
    }
    return a
}


let sortedHighToLow = insertionSort(list, >)
let sortedLowToHigh = insertionSort(list, <)

let strings = ["banana", "apple", "dates", "cucumber", "eggplant"]
let stringsSorted = insertionSort(strings, <)

//the closure here tells the funciton to sort on the priority property of these objects
//let objects = [ obj1, obj2, obj3 ...]
//insertionSort(objects) { $0.priority < $1.priority)}
