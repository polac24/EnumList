//
//  EnumListRawEncodable.swift
//  EnumList
//
//  Created by Bartosz Polaczyk on 27/08/2017.
//

import Foundation

public extension RawRepresentable where RawValue:EnumListStringRawable{
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue.value)
    }
}

public extension RawRepresentable where RawValue:EnumListIntRawable{
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue.value)
    }
}

