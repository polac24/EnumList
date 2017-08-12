//
//  EnumValuesExtensions.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit

public extension EnumValues where Element.RawValue == EnumListRaw<Self>, RawType == String{
    static var all: Set<Element> {
        let a =  allRaws.map({EnumListRaw<Self>(stringLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
    static func initialize(){
        self.allRaws = []
        _ = Element(rawValue: EnumListRaw<Self> ())
    }
}

public extension EnumValues where Element.RawValue == EnumListRaw<Self>, RawType == Int{
    static var all: Set<Element> {        
        let a =  allRaws.map({EnumListRaw<Self>(integerLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
    static func initialize(){
        self.allRaws = []
        _ = Element(rawValue: EnumListRaw<Self> ())
    }
}
