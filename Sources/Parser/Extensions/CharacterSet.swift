//
//  File.swift
//  
//
//  Created by neutralradiance on 9/17/20.
//

import Foundation

extension CharacterSet {
    public static var delimiters: Self {
        var set = CharacterSet.alphanumerics.inverted
        set.remove("_")
        set.remove("#")
        set.remove("@")
        set.remove("$")
        return set
    }
}
