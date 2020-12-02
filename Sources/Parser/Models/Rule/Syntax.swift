//
//  File.swift
//  
//
//  Created by neutralradiance on 12/2/20.
//

import Foundation

/// A wrapper to build a rule-based syntax.
public struct Syntax: Codable, Hashable, Equatable {
    public var elements: [Rule]
}

extension Syntax {
    public init(@SyntaxBuilder _ elements: () -> [Rule]) {
        self.elements = elements()
    }
}

@_functionBuilder
public struct SyntaxBuilder {
    public static func buildBlock(_ elements: Rule...) -> Syntax {
        Syntax(elements: elements)
    }
}
