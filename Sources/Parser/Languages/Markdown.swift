//
//  File.swift
//
//
//  Created by neutralradiance on 9/23/20.
//

import Foundation

public struct Markdown: ParsingLanguage {
    public var name: String { "markdown" }
    public var identifier: String { "net.daringfireball.markdown" }
    public var delimiters: CharacterSet { .delimiters }
    public var rules: Syntax {
            // italic
            Rule(
                context: .custom(traits: .italic),
                regex: "(?<!_)_[^_]+_(?!\\*)"
            )
            Rule(
                context: .custom(traits: .italic),
                regex: "(?<!\\*)(\\*)((?!\\1).)+\\1(?!\\*)"
            )
            // bold
            Rule(
                context: .custom(traits: .bold),
                regex: "((\\*|_){2})((?!\\1).)+\\1"
            )
            // bold & italic
            Rule(
                context: .custom(traits: .italic),
                regex: "(\\*){3}((?!\\1).)+\\1{3}"
            )
            // strikethrough
            Rule(
                context: .custom(traits: .strikethrough),
                regex: "(~)((?!\\1).)+\\1"
            )
            // horizontal rule
            Rule(
                context: .comment,
                regex: "\n\n(-{3}|\\*{3})\n"
            )
            // unordered list
            Rule(
                context: .comment,
                regex: "^(\\-|\\*)\\s",
                options: [.anchorsMatchLines]
            )
            // ordered list
            Rule(
                context: .comment,
                regex: "^\\d*\\.\\s",
                options: [.anchorsMatchLines]
            )
            // button
            Rule(
                context: .comment,
                regex: "<\\s*button[^>]*>(.*?)<\\s*/\\s*button>"
            )
            // link
            Rule(
                context: .literal,
                regex: "!?\\[([^\\[\\]]*)\\]\\((.*?)\\)"
            )
            // block quote *lightens background*
            Rule(
                context: .blockQuote,
                regex: "^>.*",
                options: [.anchorsMatchLines]
            )
            // inline code
            Rule(
                context: .literal,
                regex: "`[^`]*`"
            )
            // code block
            Rule(
                context: .literal,
                regex: "(`){3}((?!\\1).)+\\1{3}",
                options: [.dotMatchesLineSeparators]
            )
            // heading
            Rule(
                context: .custom(traits: .bold),
                regex: "^#{1,6}\\s.*$",
                options: [.anchorsMatchLines]
            )
    }
    public init() {}
}

//let urlpattern = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
