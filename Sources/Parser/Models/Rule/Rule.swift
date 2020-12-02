//
//  File.swift
//  
//
//  Created by neutralradiance on 9/7/20.
//

import SwiftUI
import Light

/// A rule used to provide structure for a language.
public struct Rule: Codable, Hashable {
    public var context: Context?
    public var regex: RegularExpression?
    public var options: NSRegularExpression.Options = []
}

extension Rule: Equatable {
    public static func == (lhs: Rule, rhs: Rule) -> Bool {
        lhs.context == rhs.context && lhs.regex == rhs.regex
    }
}

// MARK: - Rule Context
extension Rule {
    /// Provides context for sytax highlighting.
    public struct Context: Codable, Equatable, Hashable {
        /// The set of styles for the font.
        public var traits: Trait?
        /// A custom color. Overrides the base color.
        public var color: NativeColor?
        /// The index of a base16 based color. Defaults to the foreground.
        public var index: Int?
        /// Background fill for the font.
        public var background: NativeColor?
        /// Background fill for the font.
        public var bgIndex: Int?
        /// Marker color for the resolved token.
        public var marker: NativeColor?
        /// Alpha component for the color.
        public var alpha: Float?
        public init(traits: Trait? = nil,
                    color: NativeColor? = nil,
                    index: Int? = nil,
                    background: NativeColor? = nil,
                    bgIndex: Int? = nil,
                    marker: NativeColor? = nil,
                    alpha: Float? = nil) {
            self.traits = traits
            self.color = color
            self.index = index
            self.background = background
            self.bgIndex = bgIndex
            self.marker = marker
            self.alpha = alpha
        }
    }
}

public extension Rule.Context {
    struct Trait: OptionSet, Codable, Equatable, Hashable {
        public var rawValue: Int = 0
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static var ultralight: Self { Self(rawValue: 0) }
        public static var light: Self { Self(rawValue: 1) }
        public static var thin: Self { Self(rawValue: 2) }
        public static var medium: Self { Self(rawValue: 3) }
        public static var regular: Self { Self(rawValue: 4) }
        public static var semibold: Self { Self(rawValue: 5) }
        public static var bold: Self { Self(rawValue: 6) }
        public static var heavy: Self { Self(rawValue: 7) }
        public static var black: Self { Self(rawValue: 8) }
        public static var condensed: Self { Self(rawValue: 9) }
        public static var italic: Self { Self(rawValue: 10) }
        public static var underline: Self { Self(rawValue: 11) }
        public static var strikethrough: Self { Self(rawValue: 12) }

        public var symbolic: FontDescriptor.SymbolicTraits? {
            #if os(macOS)
            switch self {
                case .bold: return .bold
                case .italic: return .italic
                case .condensed: return .condensed
                default: return nil
            }
            #elseif os(iOS)
            switch self {
                case .bold: return .traitBold
                case .italic: return .traitItalic
                case .condensed: return .traitCondensed
                default: return nil
            }
            #endif
        }
    }

    static func custom(traits: Trait? = nil,
                       color: NativeColor? = nil,
                       index: Int? = nil,
                       background: NativeColor? = nil,
                       bgIndex: Int? = nil,
                       marker: NativeColor? = nil,
                       alpha: Float? = nil,
                       relativeTo context: Rule.Context = Rule.Context()) -> Rule.Context {
        var base = context
        if let traits = traits {
            base.traits = traits
        }
        if let color = color {
            base.color = color
        } else if let index = index {
            base.index = index
        }
        if let alpha = alpha {
            base.alpha = alpha
        }
        if let background = background {
            base.background = background
        }
        if let bgIndex = bgIndex {
            base.bgIndex = bgIndex
        }
        if let marker = marker {
            base.marker = marker
        }
        return base
    }
}

extension Rule.Context {
    static var plain: Self {
        Self(traits: .regular, index: 4)
    }
    static var keyword: Self {
        Self(traits: .bold, index: 14)
    }
    static var type: Self {
        Self(traits: .bold, index: 10)
    }
    static var string: Self {
        Self(traits: .bold, index: 11)
    }
    static var function: Self {
        Self(index: 13)
    }
    static var instance: Self {
        Self(index: 8)
    }
    static var literal: Self {
        Self(index: 9)
    }
    static var comment: Self {
        Self(traits: .bold, index: 3)
    }
    static var documentation: Self {
        Self(index: 3)
    }
    static var blockQuote: Self {
        Self(bgIndex: 1)
    }
}
