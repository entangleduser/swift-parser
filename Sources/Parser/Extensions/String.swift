//
//  File.swift
//  
//
//  Created by neutralradiance on 9/17/20.
//

import Foundation

extension String {
    func createBuffer() -> [[Character]] {
        components(separatedBy: .newlines).compactMap {
            $0.compactMap {
                 Character(extendedGraphemeClusterLiteral: $0) }
        }.compactMap { $0.isEmpty ? ["\n"] : $0+"\n" }
    }
    var escaped: String {
        NSRegularExpression.escapedPattern(for: self)
    }
    func regularExpression(_ options: NSRegularExpression.Options = []) -> NSRegularExpression? {
        try? NSRegularExpression(pattern: self, options: options)
    }
    func matches(_ string: String,
                 options: NSRegularExpression.Options = [],
                 matchingOptions: NSRegularExpression.MatchingOptions = []) -> [NSRange]? {
        regularExpression(options)?.matches(string, options: matchingOptions)
    }
    var range: NSRange? {
        return NSRange(location: 0, length: count)
    }
    var isNumber: Bool {
        allSatisfy { !$0.isLetter && ($0.isNumber || $0 == "." || $0 == "_") }
    }
    public var objectFormat: String {
        var string = self
            .split(separator: "(", maxSplits: 1).joined(separator: "(\n    ")
            .split(separator: ",").joined(separator: ",\n   ")
        let last = String(string.removeLast())
        return string.appending("\n"+last)
    }
    public init<Object: Any>(object: Object?) {
        guard let object = object else {
            self.init("nil")
            return
        }
        self.init(String(describing: object).objectFormat)
    }
}
extension NSRegularExpression {
    func matches(_ string: String, options: NSRegularExpression.MatchingOptions = []) -> [NSRange]? {
        guard let range = string.range else { return nil }
        return matches(in: string, options: options, range: range).map { $0.range }
    }
}
//extension Array where Element == String {
//    func matches(_ string: String,
//                 options: NSRegularExpression.Options = [],
//                 matchOptions: NSRegularExpression.MatchingOptions = []) -> [NSRange]? {
//        let matches: [NSRange] =
//            string.regularExpression(options)?.matches(string, options: matchOptions)
//        guard matches.count > 0 else { return nil }
//        return matches
//    }
//}

