//
//  File.swift
//  
//
//  Created by neutralradiance on 12/5/20.
//

import Foundation

public struct Bash: ParsingLanguage {
    public var name: String { "bash" }
    public var delimiters: CharacterSet { .delimiters }
    public var rules: Syntax {
        Rule()
    }
    public init() {}
}
