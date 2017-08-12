//
//  EnumValuesExtensions.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit

public extension EnumValues where Element.RawValue == EnumListRawRepresentable<Self>, RawType == String{
    static func all() -> Set<Element> {
        _ = Element(rawValue: EnumListRawRepresentable<Self> ())
        
        let a =  allRaws.map({EnumListRawRepresentable<Self>(stringLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
}

public extension EnumValues where Element.RawValue == EnumListRawRepresentable<Self>, RawType == Int{
    static func all() -> Set<Element> {
        _ = Element(rawValue: EnumListRawRepresentable<Self> ())
        
        let a =  allRaws.map({EnumListRawRepresentable<Self>(integerLiteral: $0)})
        return Set(a.flatMap({
            return Element(rawValue: $0)
        }))
    }
}
