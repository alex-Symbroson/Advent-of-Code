
import Foundation

func readinput(n: String) -> String { 
    try!
        NSString(contentsOfFile: n, encoding: String.Encoding.utf8.rawValue)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

    func split(_ sep: String) -> [SubSequence] {
        return split(separator: sep)
    }
}

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { i in self.map { $0[i] }}
    }
}


//  Created by Damiaan Dufaux on 21/08/16.
//  Copyright © 2016 Damiaan Dufaux. All rights reserved.

extension Array where Element: Comparable
{
    func binarySearch(element: Element) -> Int
    {
        var low = startIndex, high = endIndex
        while low != high
        {
            let mid = low.advanced(by: low.distance(to: high) / 2)
            if self[mid] < element { low = mid.advanced(by: 1) }
            else { high = mid }
        }
        return low
    }
    
    mutating func sortedInsert(newElement: Element) {
        insert(newElement, at: binarySearch(element: newElement) )
    }
}
