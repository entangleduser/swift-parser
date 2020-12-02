//
//  File.swift
//  
//
//  Created by neutralradiance on 12/2/20.
//

import Foundation

/// A codable wrapper for regular expressions.
public struct RegularExpression: Codable,
                                 Hashable,
                                 Equatable,
                                 ExpressibleByStringLiteral,
                                 ExpressibleByArrayLiteral {
    public var keywords: [String] = []
    public var expression: String?
    public init(keywords: [String] = [], expression: String? = nil) {
        self.keywords = keywords
        self.expression = expression
    }
    public init(stringLiteral value: String) {
        self.init(expression: value)
    }
    public init(arrayLiteral elements: String...) {
        self.init(keywords: elements)
    }
}

extension NSRegularExpression.Options: Codable, Hashable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(rawValue: container.decode(UInt.self))
    }
}
