//
//  EnumListEncodableTests.swift
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


extension SubjectString:Codable{}
extension SubjectInt:Codable{}


class EnumListEncodableTests: XCTestCase {
    struct Subjects:Codable, Equatable {
        static func ==(lhs: Subjects, rhs: Subjects) -> Bool {
            return lhs.subjectString == rhs.subjectString && lhs.subjectInt == rhs.subjectInt
        }
        
        fileprivate let subjectString:SubjectString
        fileprivate let subjectInt:SubjectInt
    }
    
    struct OptionalSubjects:Codable, Equatable {
        static func ==(lhs: OptionalSubjects, rhs: OptionalSubjects) -> Bool {
            return lhs.subjectString == rhs.subjectString && lhs.subjectInt == rhs.subjectInt
        }
        
        fileprivate let subjectString:SubjectString?
        fileprivate let subjectInt:SubjectInt?
    }
    
    func testDecodesCorrectlyEnumListRaws() throws{
        // Arrange
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let subjects = Subjects(subjectString: .caseNo1, subjectInt: .caseNo2)
        
        // Act
        let subjectsData:Data
        do{
            subjectsData = try encoder.encode(subjects)
        }catch{
            XCTFail("Unexpected errorr")
            throw error
        }
        
        // Assert
        try XCTAssertEqual(subjects, decoder.decode(Subjects.self, from: subjectsData))
    }
    
    func testDecodesCorrectlyOptionalEnumListRaws() throws{
        // Arrange
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let subjects = OptionalSubjects(subjectString: .caseNo1, subjectInt: .caseNo2)
        
        // Act
        let subjectsData:Data
        do{
            subjectsData = try encoder.encode(subjects)
        }catch{
            XCTFail("Unexpected errorr")
            throw error
        }
        
        // Assert
        try XCTAssertEqual(subjects, decoder.decode(OptionalSubjects.self, from: subjectsData))
    }
    
    func testDecodesCorrectlyNilEnumListRaws() throws{
        // Arrange
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let subjects = OptionalSubjects(subjectString: nil, subjectInt: nil)
        
        // Act
        let subjectsData:Data
        do{
            subjectsData = try encoder.encode(subjects)
        }catch{
            XCTFail("Unexpected errorr")
            throw error
        }
        
        // Assert
        try XCTAssertEqual(subjects, decoder.decode(OptionalSubjects.self, from: subjectsData))
    }
}

