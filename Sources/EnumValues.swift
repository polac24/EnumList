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
    associatedtype RawType:Hashable, RawTypeable
    
    
    static var allRaws:Set<RawType> {get set}
    static var all: Set<Element> {get}
}
