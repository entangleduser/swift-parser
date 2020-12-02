//
//  File.swift
//  
//
//  Created by neutralradiance on 12/2/20.
//

import Foundation

public protocol ParsingLanguage: Language {
    func lex(input: String, output: (ParseContext) -> Void) throws -> Result<ParseResult?, ParseError>
}

extension ParsingLanguage {
    public func lex(input: String, output: (ParseContext) -> Void) throws -> Result<ParseResult?,ParseError> {
        guard let tokens = input.tokenize(delimiters) else { return .failure(.empty) }
        rules.elements.forEach { rule in
            var result = ParseContext(context: rule.context)
            if let expr = rule.regex?.expression,
               let matches = expr.matches(input, options: rule.options) {
                result.ranges += matches
            }
            if let keywords = rule.regex?.keywords {
                let matches = tokens.matches(array: keywords).map({ $0.range })
                result.ranges.append(
                    contentsOf: matches
                )
            }
            result.ranges.sort(by: { $0.lowerBound > $1.lowerBound})
            output(result)
        }
        return .success(.complete)
    }
}

