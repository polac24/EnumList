//
//  APIConvenience.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import Foundation


public extension RawRepresentable{
    init?<T>(raw rawValue: String) where RawValue == EnumListStringRaw<T>, T:StringEnumValues{
        self.init(rawValue: RawValue(stringLiteral: rawValue))
    }
}
public extension RawRepresentable{
    init?<T>(raw rawValue: Int)  where RawValue == EnumListIntRaw<T>, T:IntEnumValues{
        self.init(rawValue: EnumListIntRaw<T>(integerLiteral: rawValue))
    }
}
