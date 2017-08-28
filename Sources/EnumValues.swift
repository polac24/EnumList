//
//  EnumValues.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import UIKit

public protocol EnumValues{
    associatedtype Element:RawRepresentable, Hashable
    associatedtype RawType: Hashable
    
    static var all: Set<Element> {get}
    static var allRaws:Set<RawType> {get set}
}

public protocol StringEnumValues:EnumValues{
    static var allRaws:Set<String> {get set}
}

public protocol IntEnumValues:EnumValues{
    static var allRaws:Set<Int> {get set}
}
