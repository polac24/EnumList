//
//  EnumValuesExtensions.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit
private extension EnumValues {
    static func buildAllElementsSet(conversion:(RawType)->(Element.RawValue)) -> Set<Element>{
        let arrayRawValues =  allRaws.map(conversion)
        return Set(arrayRawValues.flatMap({
            return Element(rawValue: $0)
        }))
    }
    static func resetRaws(imaginationRawValue: Element.RawValue){
        allRaws = []
        _ = Element(rawValue: imaginationRawValue)
    }
}

public extension StringEnumValues where Element.RawValue == EnumListStringRaw<Self>, RawType == String{
    static var all: Set<Element> {
        initialize()
        return buildAllElementsSet(conversion:{EnumListStringRaw<Self>(stringLiteral: $0)})
    }
    static var allRawValues: Set<String> {
        initialize()
        return allRaws
    }
    static func initialize(){
        resetRaws(imaginationRawValue: EnumListStringRaw<Self>())
    }
}

public extension IntEnumValues where Element.RawValue == EnumListIntRaw<Self>, RawType == Int{
    static var all: Set<Element> {
        initialize()
        return buildAllElementsSet(conversion:EnumListIntRaw<Self>.init)
    }
    static var allRawValues: Set<Int> {
        initialize()
        return allRaws
    }
    static func initialize(){
        resetRaws(imaginationRawValue: EnumListIntRaw<Self>())
    }
}
