//
//  EnumListRawRepresentable.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit

public struct EnumListRaw<T:EnumValues>: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, Equatable{
    let a:T.RawType?
    
    public static func ==(lhs: EnumListRaw<T>, rhs: EnumListRaw<T>) -> Bool {
        if let lhsA = lhs.a { T.allRaws.insert(lhsA)}
        if let rhsA = rhs.a { T.allRaws.insert(rhsA)}
        
        return lhs.a == rhs.a
    }
    
    public init(stringLiteral value: String){
        a = T.RawType(value)
    }
    public init(extendedGraphemeClusterLiteral value: String){
        a = T.RawType(value)
    }
    public init(unicodeScalarLiteral value: String){
        a = T.RawType(value)
    }
    public init(integerLiteral value: Int){
        a = T.RawType(value)
    }
    
    public init(){
        a = nil
    }
}
