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
        _ = Element(rawValue: EnumListRaw<Self> ())
        
        let a =  allRaws.map({EnumListRaw<Self>(stringLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
}

public extension EnumValues where Element.RawValue == EnumListRaw<Self>, RawType == Int{
    static var all: Set<Element> {
        _ = Element(rawValue: EnumListRaw<Self> ())
        
        let a =  allRaws.map({EnumListRaw<Self>(integerLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
}
