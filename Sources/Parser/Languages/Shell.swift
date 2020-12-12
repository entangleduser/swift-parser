//
//  File.swift
//  
//
//  Created by neutralradiance on 12/5/20.
//

import Foundation

public struct Shell: ParsingLanguage {
    public var name: String { "shell" }
    public var identifier: String { "public.shell-script" }
    public var delimiters: CharacterSet { .delimiters }
    public var rules: Syntax {
        Rule()
    }
    public init() {}
}
