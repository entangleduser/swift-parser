//
//  File.swift
//  
//
//  Created by neutralradiance on 12/2/20.
//

import Foundation

public enum ParseError: Error {
    case missing(Rule.Context), empty, any(String)
}

