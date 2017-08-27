//
//  EnumListRawDecodable.swift
//  EnumList
//
//  Created by Bartosz Polaczyk on 27/08/2017.
//

import Foundation

private extension RawRepresentable{
    /// Throws only when cannot create instance from a given rawValue
    ///
    /// Required by a limitation of Decoder initalizer that cannot
    /// delegate to failable initailizer without implcit unwrap
    static func ensureExists(rawValue: RawValue, codingPath: [CodingKey]) throws{
        if self.init(rawValue: rawValue) == nil{
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath, debugDescription: "Invalid value to create \(Self.self) from: \(rawValue)"))
        }
    }
}

public extension RawRepresentable where RawValue:EnumListStringRawable{
    init(from decoder: Decoder) throws {
        let decoded = try decoder.singleValueContainer().decode(String.self)
        let rawValue = RawValue(stringLiteral: decoded)
        /// forces intializer to throw an error in case given string does not
        /// correspond to any RawRepresentable instance
        try Self.ensureExists(rawValue: rawValue, codingPath: decoder.codingPath)
        self.init(rawValue: RawValue(stringLiteral: decoded))!
    }
}

public extension RawRepresentable where RawValue:EnumListIntRawable{
    init(from decoder: Decoder) throws {
        let decoded = try decoder.singleValueContainer().decode(Int.self)
        let rawValue = RawValue(integerLiteral: decoded)
        /// forces intializer to throw an error in case given string does not
        /// correspond to any RawRepresentable instance
        try Self.ensureExists(rawValue: rawValue, codingPath: decoder.codingPath)
        self.init(rawValue: rawValue)!
    }
}
