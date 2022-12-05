
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
}

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { i in self.map { $0[i] }}
    }
}