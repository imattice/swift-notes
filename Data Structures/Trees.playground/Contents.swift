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

let tree = TreeNode<String>(value: "Beverages")

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

tree.addChild(hotNode)
tree.addChild(coldNode)

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

print(tree)

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

tree.search("cocoa")
tree.search("chai")
tree.search("water")

// - This tree can also be described in an array.  Each entry has a pointer to its parent node.  For example, the item at index 3, "tea", has the value 1 because its parent is hot.  Using this method, you can trace nodes back to the root, but you cannot trace the root to a specific node
//0 = beverage    5 = cocoa       9  = green
//1 = hot         6 = soda        10 = chai
//2 = cold        7 = milk        11 = ginger ale
//3 = tea         8 = black       12 = bitter lemon
//4 = coffee

[ -1, 0, 0, 1, 1, 1, 2, 2, 3, 3, 3, 6, 6 ]


































































