// Copyright © 2020 Brad Howes. All rights reserved.

/**
 Helper class that keeps track of the costs involved in reaching a given position in the map. Maintains a linked list
 of nodes that make up a path to the starting position.
 */
internal final class Node<PosType : Hashable>
{
    /// Lcation of this node in a map
    var position: PosType

    /// The total cost of this node: the known cost from the start + the estimated cost to the end
    private(set) var totalCost: Int = 0

    /// How must did it cost to enter this location
    private let positionCost: Int

    /// The link to the previous node in the path of nodes
    private var parent: Node?

    /// If true, allow reparenting. This is allowed up until a node `lock` is invoked.
    private var canReparent: Bool = true

    /// This is the known cost of the path to reach this node. Anything beyond is a heuristic cost, up until this is
    /// locked.
    private var knownCost: Int = 0

    /**
     Create a new root node (one without a parent)

     - parameter position: the location of the node in the map
     - parameter heuristicRemaining: the estimated cost travelling to the goal position
     */
    init(position: PosType, heuristicRemaining: Int) {
        self.position = position
        self.positionCost = 0
    }

    /**
     Create a new node that extends the path of a parent Node

     - parameter position: the location of the node in the map
     - parameter cost: the cost of travelling into this node
     - parameter heuristicRemaining: the estimated cost travelling to the goal position
     - parameter parent: the parent node representing the path to this node
     */
    init(position: PosType, cost: Int, heuristicRemaining: Int, parent: Node) {
        self.position = position
        self.positionCost = cost
        self.parent = parent
        setCosts(parentKnownCost: parent.knownCost, heuristicCost: heuristicRemaining)
    }

    /**
     Compare the current cost to this node with the estimated cost via another node, and if cheaper move the node to
     the new parent.

     - parameter heuristicRemaining: the estimated cost travelling to the goal position
     - parameter newParent: the Node to reparent if warranted
     - returns: true if reparenting took place
     */
    func reparentIfCheaper(heuristicRemaining: Int, newParent: Node) -> Node? {
        guard canReparent else { return nil }
        if (heuristicRemaining + positionCost + newParent.knownCost) < totalCost {
            self.parent = newParent
            setCosts(parentKnownCost: newParent.knownCost, heuristicCost: heuristicRemaining)
            return self
        }
        return nil
    }

    /**
     Stop any further reparenting checks on this path.
     */
    func lock() { canReparent = false }

    /**
     Obtain the path from the first Node in the chain to this one.

     - returns: array of PosType values
     */
    func path() -> [PosType] {
        guard let parent = self.parent else { return [position] }
        return parent.path() + [position]
    }
}

extension Node {
    private func setCosts(parentKnownCost: Int, heuristicCost: Int) {
        knownCost = positionCost + parentKnownCost
        totalCost = knownCost + heuristicCost
    }
}

extension Node: Comparable {
    static func == (left: Node, right: Node) -> Bool { left.totalCost == right.totalCost }
    static func < (left: Node, right: Node) -> Bool { left.totalCost < right.totalCost }
}
