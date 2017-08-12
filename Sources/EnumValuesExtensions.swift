//
//  EnumValuesExtensions.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit

public extension EnumValues where Element.RawValue == EnumListStringRaw<Self>, RawType == String{
    static var all: Set<Element> {
        let a =  allRaws.map({EnumListStringRaw<Self>(stringLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
    static func initialize(){
        self.allRaws = []
        _ = Element(rawValue: EnumListStringRaw<Self> ())
    }
}

public extension EnumValues where Element.RawValue == EnumListIntRaw<Self>, RawType == Int{
    static var all: Set<Element> {        
        let a =  allRaws.map({EnumListIntRaw<Self>(integerLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
    static func initialize(){
        self.allRaws = []
        _ = Element(rawValue: EnumListIntRaw<Self> ())
    }
}
