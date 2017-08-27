//
//  EnumListRawRepresentable.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import Foundation

public protocol EnumListStringRawable{
    init(stringLiteral value: String)
    var value:String? {get}
}

public struct EnumListStringRaw<T:StringEnumValues>: EnumListStringRawable, ExpressibleByStringLiteral, Equatable{
    public var value: String?{
        return a
    }
    
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


public protocol EnumListIntRawable{
    init(integerLiteral value: Int)
    var value:Int? {get}
}

public struct EnumListIntRaw<T:IntEnumValues>: EnumListIntRawable, ExpressibleByIntegerLiteral, Equatable {
    public var value: Int?{
        return a
    }
    
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
