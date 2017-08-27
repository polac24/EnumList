//
//  EnumListCodableTests.swift
//  EnumListProjectTests
//
//  Created by Bartosz Polaczyk on 27/08/2017.
//  Copyright © 2017 Bartosz Polaczyk. All rights reserved.
//

import XCTest
import EnumList



private enum SubjectString: EnumListStringRaw<SubjectString.Values>, RawRepresentable{
    struct Values:StringEnumValues {
        typealias Element = SubjectString
        
        static var allRaws:Set<String> = []
    }
    
    case caseNo1 = "case1"
    case caseNo2 = "case2"
}

private enum SubjectInt: EnumListIntRaw<SubjectInt.Values>, RawRepresentable{
    struct Values:IntEnumValues {
        typealias Element = SubjectInt
        
        static var allRaws:Set<Int> = []
    }
    
    case caseNo1 = 1
    case caseNo2 = 2
}


extension SubjectString:Decodable{}
extension SubjectInt:Decodable{}


class EnumListDecodableTests: XCTestCase {
    struct Subjects:Decodable, Equatable {
        static func ==(lhs: Subjects, rhs: Subjects) -> Bool {
            return lhs.subjectString == rhs.subjectString && lhs.subjectInt == rhs.subjectInt
        }
        
        fileprivate let subjectString:SubjectString
        fileprivate let subjectInt:SubjectInt
    }
    
    func testDecodesCorrectlyEnumListRaws(){
        // Arrange
        let decoder = JSONDecoder()
        let json = """
    {
        "subjectString": "case1",
        "subjectInt": 2
    }
""".data(using: .utf8)!
        
        // Act
        let subjects = try? decoder.decode(Subjects.self, from: json)

        // Assert
        XCTAssertEqual(subjects, Subjects(subjectString: .caseNo1, subjectInt: .caseNo2))
    }
    
    func testDecodingThrowsAnErrorWhenStringDataDoesNotCorrespondToEnum(){
        // Arrange
        let decoder = JSONDecoder()
        let json = """
    {
        "subjectString": "NON_EXISTING",
        "subjectInt": 2
    }
""".data(using: .utf8)!
        
        // Act
        var errorObserved:Error?
        do{
            _ = try decoder.decode(Subjects.self, from: json)
        }catch{
            errorObserved = error
        }
        
        // Assert
        switch(errorObserved){
        case .some(DecodingError.dataCorrupted):
            break
        default: XCTFail("Expecting dataCorrupted error")
        }
    }
    
    func testDecodingThrowsAnErrorWhenIntDataDoesNotCorrespondToEnum(){
        // Arrange
        let decoder = JSONDecoder()
        let json = """
    {
        "subjectString": "case1",
        "subjectInt": -1
}
""".data(using: .utf8)!
        
        // Act
        var errorObserved:Error?
        do{
            _ = try decoder.decode(Subjects.self, from: json)
        }catch{
            errorObserved = error
        }
        
        // Assert
        switch(errorObserved){
        case .some(DecodingError.dataCorrupted):
            break
        default: XCTFail("Expecting dataCorrupted error")
        }
    }
    
    func testDecodingThrowsAnErrorWhenExpectedStringValueIsOtherType(){
        // Arrange
        let decoder = JSONDecoder()
        let json = """
    {
        "subjectString": 1,
        "subjectInt": 1
}
""".data(using: .utf8)!
        
        // Act
        var errorObserved:Error?
        do{
            _ = try decoder.decode(Subjects.self, from: json)
        }catch{
            errorObserved = error
        }
        
        // Assert
        switch(errorObserved){
        case .some(DecodingError.typeMismatch):
            break
        default: XCTFail("Expecting typeMismatch error")
        }
    }
    
    func testDecodingThrowsAnErrorWhenExpectedIntValueIsOtherType(){
        // Arrange
        let decoder = JSONDecoder()
        let json = """
    {
        "subjectString": "case1",
        "subjectInt": "nonNumber"
}
""".data(using: .utf8)!
        
        // Act
        var errorObserved:Error?
        do{
            _ = try decoder.decode(Subjects.self, from: json)
        }catch{
            errorObserved = error
        }
        
        // Assert
        switch(errorObserved){
        case .some(DecodingError.typeMismatch):
            break
        default: XCTFail("Expecting typeMismatch error")
        }
    }
    
}
