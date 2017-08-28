//
//  EnumListRawRepresentable.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import Foundation


public struct EnumListStringRaw<T:StringEnumValues>: ExpressibleByStringLiteral, Equatable{
    
    
    let a:String?
    
    public static func ==(lhs: EnumListStringRaw<T>, rhs: EnumListStringRaw<T>) -> Bool {
        if let lhsA = lhs.a { T.allRaws.insert(lhsA)}
        if let rhsA = rhs.a { T.allRaws.insert(rhsA)}
        
        return lhs.a == rhs.a
    }
    
    public init(stringLiteral value: String){
        a = value
    }
    public init(extendedGraphemeClusterLiteral value: String){
        a = value
    }
    public init(unicodeScalarLiteral value: String){
        a = value
    }
    
    init(){
        a = nil
    }
}


public struct EnumListIntRaw<T:IntEnumValues>: ExpressibleByIntegerLiteral, Equatable {
    
    let a:Int?
    
    public static func ==(lhs: EnumListIntRaw<T>, rhs: EnumListIntRaw<T>) -> Bool {
        if let lhsA = lhs.a { T.allRaws.insert(lhsA)}
        if let rhsA = rhs.a { T.allRaws.insert(rhsA)}
        
        return lhs.a == rhs.a
    }
    public init(integerLiteral value: Int){
        a = value
    }
    
    init(){
        a = nil
    }
}
