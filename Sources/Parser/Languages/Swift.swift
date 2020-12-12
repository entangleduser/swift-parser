//
//  File.swift
//  
//
//  Created by neutralradiance on 12/2/20.
//

import Foundation

public struct Swift: ParsingLanguage {
    public var name: String { "swift" }
    public var identifier: String { "public.swift-source" }
    public var delimiters: CharacterSet { .delimiters }
    public var rules: Syntax {
        Rule( // number literals
            context: .literal,
            regex: "\\b([\\d_]+(\\.[\\deE_]+)?|0x[a-fA-F0-9_]+(\\.[a-fA-F0-9p_]+)?|0b[01_]+|0o[0-7_]+)\\b"
        )
        Rule( // functions
            context: .function,
            regex: "[A-Za-z_]+(?=\\()"
        )
        Rule( // identifiers
            context: .instance,
            regex: "\\.[A-Za-z_]+\\w*"
        )
        Rule( // types by capitalization
            context: .type,
             regex: "\\b[A-Z][\\wÀ-ʸ']*"
        )
        Rule( // types by name
            context: .type,
             regex: [
                "Any", "Array", "AutoreleasingUnsafePointer", "BidirectionalReverseView", "Bit", "Bool",
                "CFunctionPointer", "COpaquePointer", "CVaListPointer", "Character", "CollectionOfOne",
                "ConstUnsafePointer", "ContiguousArray", "Data", "Dictionary", "DictionaryGenerator",
                "DictionaryIndex", "Double", "EmptyCollection", "EmptyGenerator", "EnumerateGenerator",
                "FilterCollectionView", "FilterCollectionViewIndex", "FilterGenerator", "FilterSequenceView",
                "Float", "Float80", "FloatingPointClassification", "GeneratorOf", "GeneratorOfOne",
                "GeneratorSequence", "HeapBuffer", "HeapBuffer", "HeapBufferStorage", "HeapBufferStorageBase",
                "ImplicitlyUnwrappedOptional", "IndexingGenerator", "Int", "Int16", "Int32", "Int64", "Int8",
                "IntEncoder", "LazyBidirectionalCollection", "LazyForwardCollection", "LazyRandomAccessCollection",
                "LazySequence", "Less", "MapCollectionView", "MapSequenceGenerator", "MapSequenceView",
                "MirrorDisposition", "ObjectIdentifier", "OnHeap", "Optional", "PermutationGenerator",
                "QuickLookObject", "RandomAccessReverseView", "Range", "RangeGenerator", "RawByte", "Repeat",
                "ReverseBidirectionalIndex", "Printable", "ReverseRandomAccessIndex", "SequenceOf", "SinkOf",
                "Slice", "StaticString", "StrideThrough", "StrideThroughGenerator", "StrideTo", "StrideToGenerator",
                "String", "Index", "UTF8View", "Index", "UnicodeScalarView", "IndexType", "GeneratorType",
                "UTF16View", "UInt", "UInt16", "UInt32", "UInt64", "UInt8", "UTF16", "UTF32", "UTF8",
                "UnicodeDecodingResult", "UnicodeScalar", "Unmanaged", "UnsafeArray", "UnsafeArrayGenerator",
                "UnsafeMutableArray", "UnsafePointer", "VaListBuilder", "Header", "Zip2", "ZipGenerator2"
             ]
            )
        Rule( // keywords
            context: .keyword,
             regex: [
                "as", "associatedtype", "break", "case", "catch", "class", "continue", "convenience",
                "default", "defer", "deinit", "else", "enum", "extension", "fallthrough", "fileprivate",
                "final", "for", "func", "get", "guard", "if", "import", "in", "init", "inout", "internal",
                "is", "lazy", "let", "mutating", "nonmutating", "open", "infix", "postfix", "operator", "override",
                "private", "protocol", "public", "repeat", "required", "rethrows", "return", "required", "self",
                "set", "static", "struct", "subscript", "super", "switch", "throw", "throws", "try", "typealias",
                "unowned", "var", "weak", "where", "while", "some", "@propertyWrapper", "@_functionBuilder",
                "@dynamicMemberLookup"
             ]
        )
        Rule( // plain literals
            context: .literal,
            regex: ["true", "false", "nil"]
        )
        Rule( // single line string
            context: .string,
            regex: "(\"|@\")[^\"\\n]*(@\"|\")"
        )
        Rule( // multi line string
            context: .string,
            regex: "(\"\"\")(.*?)(\"\"\")",
            options: .dotMatchesLineSeparators
        )
        Rule( // single line comment
            context: .comment,
            regex: "//(.*)",
            options: .anchorsMatchLines
        )
        // single line documentation
        Rule(
            context: .documentation,
            regex: "///(.*)",
            options: .anchorsMatchLines
        )
        // multi line comment
        Rule(
            context: .comment,
            regex: "(/\\*)(.*)(\\*/)",
            options: .dotMatchesLineSeparators
        )
    }
    public init() {}
}
