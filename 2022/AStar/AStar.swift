// Copyright © 2020 Brad Howes. All rights reserved.

/**
 Contains the functionality for performing A* path searches. There is only one public static method: `find`. It creates
 a new instance and then performs the search.

 The `OracleType` generic parameter provides the `Int` type that determines how costs are stored (Int, Float, etc.)
 */
public final class AStar<PosType : Hashable>
{
    typealias NodeType = Node<PosType>

    /// Function type that returns the heuristic cost for moving from a given position to an end goal (the method must
    /// have knowledge of the end goal)
    public typealias HeuristicCostFunc = (PosType) -> Int
    public typealias nextNodesFunc = (PosType) -> [PosType]
    public typealias testGoalFunc = (PosType) -> Bool

    /**
     Attempt to find the lowest-cost path from start to end positions of a given map.

     - parameter mapOracle: the map to to use for determining valid paths
     - parameter considerDiagonalPaths: if true, allow traveling diagonally from one position to another
     - parameter heuristicCost: function that returns the heuristic cost between a given position and the end
     goal
     - parameter start: the starting position in the map
     - parameter end: the end (goal) position in the map
     - returns: the array of positions that make up the lowest-cost path, or nil of none exists
     */
    public static func find(
        _ nextNodes: @escaping nextNodesFunc,
        _ testGoal: @escaping testGoalFunc,
        _ heuristicCost: @escaping HeuristicCostFunc,
        start: PosType) -> [PosType]?
    {
        return AStar(nextNodes, testGoal, heuristicCost)
            .find(start: start)
    }

    private let nextNodes: nextNodesFunc
    private let testGoal: testGoalFunc
    private let heuristicCost: HeuristicCostFunc
    private var openQueue: [NodeType] = []
    private var nodeCache = [PosType: NodeType]()

    private init(
        _ nextNodes: @escaping nextNodesFunc,
        _ testGoal: @escaping testGoalFunc,
        _ heuristicCost: @escaping HeuristicCostFunc)
    {
        self.nextNodes = nextNodes
        self.testGoal = testGoal
        self.heuristicCost = heuristicCost
    }
}

// MARK: - Private Implementation

extension AStar {

    private func find(start: PosType) -> [PosType]?
    {
        enqueue(position: start)
        while openQueue.count > 0 {
            let node = openQueue.removeFirst()
            if testGoal(node.position) { return node.path() }
            nextNodes(node.position).forEach { enqueue(position: $0, parent: node) }
        }
        return nil
    }

    private func enqueue(position: PosType)
    {
        let node = Node(position: position, heuristicRemaining: heuristicCost(position))
        nodeCache[position] = node
        openQueue.sortedInsert(newElement: node)
    }

    private func enqueue(position: PosType, parent: NodeType)
    {
        guard let node = visit(position: position, parent: parent) else { return }
        openQueue.sortedInsert(newElement: node)
    }

    private func visit(position: PosType, parent: NodeType) -> NodeType?
    {
        let heuristicRemaining = heuristicCost(position)
        if let node = nodeCache[position] {
            return node.reparentIfCheaper(heuristicRemaining: heuristicRemaining, newParent: parent)
        }

        let node = Node(position: position, cost: 1,
                        heuristicRemaining: heuristicRemaining, parent: parent)
        nodeCache[position] = node
        return node
    }
}
