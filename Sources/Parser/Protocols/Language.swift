import Foundation

public protocol Language: Codable {
    var name: String { get }
    var delimiters: CharacterSet { get }
    @SyntaxBuilder
    var rules: Syntax { get }
}
