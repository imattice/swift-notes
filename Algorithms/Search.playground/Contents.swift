//BINARY SEARCH
//  - Used to quickly find an element in an array
//  - The array to be searched through must be sorted
//        - is this a problem?  Keep in mind that sorting takes time so the combination of sorting plus a binary search may be slower than a simple linear search.  Binary search is best when you can sort once and do many searches
//  - The method involves dividing the array in half and comparing the two.  When the search key is found in one of the halves, split that half of the array again and compare once again.  Continue to do this until the result is found.
//  - The array isn't actually split into two.  The range that the result is in is contained with the swift Range object.  As the array is "split", the range becomes smaller and smaller.
//        - One thing to keep in mind is the range.upperBound always points to one greater than the actual last element.  This is because we start counting at 0.
//  - Binary Search can be recursive or iterative.  The recursive version applies the same logic over and over on smaller and smaller subarrays.  The iterative version uses a loop instead of recursive function calls

func recursiveBinarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        // if this happens, the search key is not in the array
        return nil
    } else {
        // calculate where to split the array
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        //check if the search key is in the left half
        if a[midIndex] > key {
            return recursiveBinarySearch(a, key: key, range: range.lowerBound ..< midIndex)
            // check if the search key is in the right half
        } else if a[midIndex] < key {
            return recursiveBinarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
            // once the method reaches this point, we have found the key!
        } else {
            return midIndex
        }
    }
}

let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
recursiveBinarySearch(numbers, key: 43, range: 0 ..< numbers.count)

func iterativeBinarySerach<T: Comparable>(_ array: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = array.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if array[midIndex] == key {
            return midIndex
        } else if array[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

iterativeBinarySerach(numbers, key: 5)