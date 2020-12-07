//
//  File.swift
//  
//
//  Created by neutralradiance on 12/5/20.
//

import Foundation

public struct EmptyLanguage: Language {
    public var name: String { "none" }
    public var delimiters: CharacterSet { .delimiters }
    public var rules: Syntax {
        Rule()
    }
    public init() {}
}
