//
//  EnumList+Unbox.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit
import Unbox



public extension UnboxableEnum where RawValue:ExpressibleByStringLiteral{
    static func unbox(value: Any, allowInvalidCollectionElements: Bool) throws -> Self? {
        guard let literal = value as? RawValue.StringLiteralType else {
            return nil
        }
        
        return self.init(rawValue: RawValue(stringLiteral: literal))
    }
}

public extension UnboxableEnum where RawValue:ExpressibleByIntegerLiteral{
    static func unbox(value: Any, allowInvalidCollectionElements: Bool) throws -> Self? {
        guard let literal = value as? RawValue.IntegerLiteralType else {
            return nil
        }
        
        return self.init(rawValue: RawValue(integerLiteral: literal))
    }
}
