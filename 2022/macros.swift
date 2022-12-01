
import Foundation

func readinput(n: String) -> String { 
    try!
        NSString(contentsOfFile: n, encoding: String.Encoding.utf8.rawValue, error: "file not found")
        .trimmingCharacters(in: .whitespacesAndNewlines)
}