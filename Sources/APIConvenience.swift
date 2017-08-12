//
//  APIConvenience.swift
//  Pods
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//
//

import Foundation


extension RawRepresentable{
    init?<T>(rawValue: String) where RawValue == EnumListStringRaw<T>, T:EnumValues{
        self.init(rawValue: EnumListStringRaw<T>(stringLiteral: rawValue))
    }
    init?<T>(rawValue: Int) where RawValue == EnumListIntRaw<T>, T:EnumValues{
        self.init(rawValue: EnumListIntRaw<T>(integerLiteral: rawValue))
    }
}
