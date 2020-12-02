//
//  File.swift
//  
//
//  Created by neutralradiance on 9/15/20.
//

import SwiftUI

#if os(macOS)
public typealias FontDescriptor = NSFontDescriptor
#elseif os(iOS)
public typealias FontDescriptor = UIFontDescriptor
#endif
import Theme
import Light

public struct Token {
    public var value: String
    public var position: Int
    public var kind: Kind?
    public init(_ value: String,_ position: Int,_  kind: Kind? = nil) {
        self.value = value
        self.position = position
        self.kind = kind
    }
}

extension Token: Hashable, Comparable {
    public static func < (lhs: Self, rhs: Token) -> Bool {
        lhs.position < rhs.position
    }
    public enum Kind: Int {
        case newline, whitespace, symbol, number, delimiter
    }
    var range: NSRange {
        NSRange(position-value.count..<position)
    }
}

// MARK: - Lexer
extension String {
    public func tokenize(_ delimiters: CharacterSet) -> [Token]? {
        guard !self.isEmpty else { return nil }
        var tokens: [Token] = []
        var token: String = ""
        var position = startIndex
        for character in self {
            let string = String(character)
            if let scalar = character.unicodeScalars.first, delimiters.contains(scalar) {
                if !token.isEmpty {
                    // check for numbers
                    tokens.append(
                        Token(
                            token, position.utf16Offset(in: self),
                            token.isNumber ?
                                .number :
                                nil
                        )
                    )
                }
                tokens.append(
                    Token(
                        string, position.utf16Offset(in: self),
                        character.isNewline ?
                            .newline :
                            character.isWhitespace ?
                            .whitespace :
                            character.isMathSymbol ?
                            .symbol :
                            character.isNumber ?
                            .number :
                            .delimiter
                    )
                )
                token = ""
            } else {
                token.append(character)
            }
            position = index(after: position)
        }
        if position == endIndex, !token.isEmpty {
            tokens.append(
                Token(
                    token, position.utf16Offset(in: self),
                    token.isNumber ?
                        .number :
                        nil
                )
            )
        }
        return tokens
    }
}

public extension Array where Element == Token {
    func matches(array: [String]) -> [Token] {
        filter { token in
            array.contains(
                where: { string in
                    token.value == string
                }
            )
        }
    }
}
