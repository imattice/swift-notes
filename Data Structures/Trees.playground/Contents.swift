import Foundation

//TREES
//  - Trees consist of nodes and leaves, layed out in a heirarchy.  Each node always has only one parent, but can have multiple children.  These relationships are not cyclical.
//    - This type of structure is a simple kind of graph
//  - The "root" is the parent node that does not have any parent nodes
//  - Sometimes, a forest refers to a collection of tree objects

public class TreeNode<T> {
    public var value: T
    
    public var parent: TreeNode?
    public var children = [TreeNode<T>]()

    public init(value: T) {
        self.value = value
    }
    public func addChild(_ node: TreeNode<T>) {
        children.append(node)
        node.parent = self
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += "{" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return s
    }
}

let beverageTree = TreeNode<String>(value: "Beverages")

let hotNode = TreeNode<String>(value: "hot")
let coldNode = TreeNode<String>(value: "cold")

let teaNode = TreeNode<String>(value: "tea")
let coffeeNode = TreeNode<String>(value: "coffee")

let chocolateNode = TreeNode<String>(value: "cocoa")

let blackTeaNode = TreeNode<String>(value: "black")
let greenTeaNode = TreeNode<String>(value: "green")
let chaiTeaNode = TreeNode<String>(value: "chai")

let sodaNode = TreeNode<String>(value: "soda")
let milkNode = TreeNode<String>(value: "milk")

let gingerAleNode = TreeNode<String>(value: "ginger ale")
let bitterLemonNode = TreeNode<String>(value: "bitter lemon")

beverageTree.addChild(hotNode)
beverageTree.addChild(coldNode)

hotNode.addChild(teaNode)
hotNode.addChild(coffeeNode)
hotNode.addChild(chocolateNode)

coldNode.addChild(sodaNode)
coldNode.addChild(milkNode)

teaNode.addChild(blackTeaNode)
teaNode.addChild(greenTeaNode)
teaNode.addChild(chaiTeaNode)

sodaNode.addChild(gingerAleNode)
sodaNode.addChild(bitterLemonNode)

print(beverageTree)

extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}

beverageTree.search("cocoa")
beverageTree.search("chai")
beverageTree.search("water")

// - This tree can also be described in an array.  Each entry has a pointer to its parent node.  For example, the item at index 3, "tea", has the value 1 because its parent is hot.  Using this method, you can trace nodes back to the root, but you cannot trace the root to a specific node
//0 = beverage    5 = cocoa       9  = green
//1 = hot         6 = soda        10 = chai
//2 = cold        7 = milk        11 = ginger ale
//3 = tea         8 = black       12 = bitter lemon
//4 = coffee

[ -1, 0, 0, 1, 1, 1, 2, 2, 3, 3, 3, 6, 6 ]





//BINARY TREE
//    - A tree structure where each node has 0, 1, or 2 children.  The child nodes are usually referred to as the left child and the right child.  If the node does not have children, it is called a leaf node.  The root is the parent node that does not have its own parent node.
//    - This data struture is often used in binary search trees.  In this case, the nodes must be smaller on the left and larger on the right.  This is not a requirement for binary trees in general.
//  - Binary trees are built in reverse, startng with leaf nodes and working your way to the root
//  - You will often need a way to traverse the binary tree, of which there are three ways to do so: 
//      - In-order or depth-first: first look ath the left child of a node, then the node itself, then its right child
//      - Pre-order: first look at the node, then at its left and right children
//      - Post-order: first look at the left and right children, then process the node itself

public indirect enum BinaryTree<T> {
    case Node(BinaryTree<T>, T, BinaryTree<T>)
    case Empty
    
    public var count: Int {
        switch self {
        case let .Node(left, _, right):
            return left.count + 1 + right.count
        case .Empty:
            return 0
        }
    }
    public func traverseInOrder(process: (T) -> Void) {
        if case let .Node(left, value, right) = self {
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }
    public func traversePreOrder(process: (T) -> Void) {
        if case let .Node(left, value, right) = self {
            process(value)
            left.traversePreOrder(process: process)
            right.traversePreOrder(process: process)
        }
    }
    public func traversePostOrder(process:(T) -> Void) {
        if case let .Node(left,value, right) = self {
            process(value)
            left.traversePostOrder(process: process)
            right.traversePostOrder(process: process)
        }
    }
}

// leaf nodes
let node5 = BinaryTree.Node(.Empty, "5", .Empty)
let nodeA = BinaryTree.Node(.Empty, "a", .Empty)
let node10 = BinaryTree.Node(.Empty, "10", .Empty)
let node4 = BinaryTree.Node(.Empty, "4", .Empty)
let node3 = BinaryTree.Node(.Empty, "3", .Empty)
let nodeB = BinaryTree.Node(.Empty, "b", .Empty)

// intermediate nodes on the left
let Aminus10 = BinaryTree.Node(nodeA, "-", node10)
let timesLeft = BinaryTree.Node(node5, "*", Aminus10)

// intermediate nodes on the right
let minus4 = BinaryTree.Node(.Empty, "-", node4)
let divide3andB = BinaryTree.Node(node3, "/", nodeB)
let timesRight = BinaryTree.Node(minus4, "*", divide3andB)

// root node
let arithmeticTree = BinaryTree.Node(timesLeft, "+", timesRight)

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .Node(left, value, right):
            return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
        case .Empty:
            return ""
        }
    }
}

arithmeticTree
arithmeticTree.count





//BINARY SEARCH TREE
//  - A Binary search tree is sorted such that all values smaller than the parent node are placed left and those greater are placed right
//  - The search process is similar to a binary search in an array, where if the value searched for is lower, then look at the left node; higher, the right.  We continue this process until the value is found or there are no nodes with that value, in which case the value is not in the tree
//  - Deleting nodes is tricky.  To remove a leaf, just disconnect it from its parent.  To disconnect a node with only one child, we can link that child node to its grandparent, effectively removing the parent.  However, to remove a node with two children, the node must be replaced by the smallest child that is larget than the node

public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(v, parent: self)
        }
    }
    public var isRoot: Bool {
        return parent == nil
    }
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    public var isRightChild: Bool {
        return parent?.right === self
    }
    public var hasLeftChild: Bool {
        return left != nil
    }
    public var hasRightChild: Bool {
        return right != nil
    }
    public var hasAnyChild: Bool {
        return hasRightChild || hasLeftChild
    }
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public func insert(_ value: T){
        insert(value, parent: self) 
    }
    private func insert(_ value: T, parent: BinarySearchTree) {
        if value < self.value {
            if let left = left {
                left.insert(value, parent: left)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = parent
            }
        } else {
            if let right = right {
                right.insert(value, parent: right)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = parent
            }
        }
    }
}

let binarySearchTree = BinarySearchTree<Int>(value: 7)
binarySearchTree.insert(2)
binarySearchTree.insert(5)
binarySearchTree.insert(10)
binarySearchTree.insert(9)
binarySearchTree.insert(1)

let binarySearchTreeFromArray = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])


























































