//
//  EnumList+Unbox.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit
import Unbox



public extension UnboxableEnum where RawValue:ExpressibleByStringLiteral, RawValue.StringLiteralType == String{
    static func unbox(value: Any, allowInvalidCollectionElements: Bool) throws -> Self? {
        guard let v = value as? String else {return nil}
        
        let a:RawValue = RawValue(stringLiteral: v)
        return self.init(rawValue:a)
    }
}

public extension UnboxableEnum where RawValue:ExpressibleByIntegerLiteral, RawValue.IntegerLiteralType == Int{
    static func unbox(value: Any, allowInvalidCollectionElements: Bool) throws -> Self? {
        guard let v = value as? Int else {return nil}
        
        let a:RawValue = RawValue(integerLiteral: v)
        return self.init(rawValue:a)
    }
}
