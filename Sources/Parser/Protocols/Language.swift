import Foundation

public protocol Language: Codable {
    var name: String { get }
    var identifier: String { get }
    var delimiters: CharacterSet { get }
    @SyntaxBuilder
    var rules: Syntax { get }
}

extension Language {
    public var name: String { "text" }
    public var identifier: String { "public.text" }
    public var delimiters: CharacterSet { .delimiters }
    @SyntaxBuilder
    public var rules: Syntax {
        Rule()
    }
}
