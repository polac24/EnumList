//
//  EnumListProjectTests.swift
//  EnumListProjectTests
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//  Copyright © 2017 Bartosz Polaczyk. All rights reserved.
//

import XCTest
import EnumList

class EnumListTests: XCTestCase {
    
    private enum SubjectString: EnumListStringRaw<SubjectString.Values>, RawRepresentable{
        struct Values:StringEnumValues {
            typealias Element = SubjectString
            
            static var allRaws:Set<String> = []
        }
        
        case caseNo1 = "case1"
        case caseNo2 = "case2"
    }
    
    private enum SubjectStringDefaultValue: EnumListStringRaw<SubjectStringDefaultValue.Values>, RawRepresentable{
        struct Values:StringEnumValues {
            typealias Element = SubjectStringDefaultValue
            
            static var allRaws:Set<String> = []
        }
        
        case caseNo1
        case caseNo2 = "case2"
    }
    
    private enum SubjectInt: EnumListIntRaw<SubjectInt.Values>, RawRepresentable{
        struct Values:IntEnumValues {
            typealias Element = SubjectInt
            
            static var allRaws:Set<Int> = []
        }
        
        case caseNo1 = 1
        case caseNo2 = 200
    }
    
    
    func testInitializingFromStringSucceeds(){
        XCTAssertEqual(SubjectString(rawValue: "case1"), .caseNo1)
    }
    func testInitializingFromUnknownStringReturnsNil(){
        XCTAssertNil(SubjectString(rawValue: "!NON_EXISTING!"))
    }
    func testInitializingFromIntSucceeds(){
        XCTAssertEqual(SubjectInt(rawValue: 200), .caseNo2)
    }
    func testInitializingFromUnknownIntReturnsNil(){
        XCTAssertNil(SubjectInt(rawValue: -1))
    }
    
    func testInitializingFromStringVariableSucceeds(){
        // Arrange
        let string = "case1"
        
        // Act
        let subject = SubjectString(raw: string)
        
        // Assert
        XCTAssertEqual(subject, .caseNo1)
    }
    func testInitializingFromIntVariableSucceeds(){
        // Arrange
        let intValue = 200
        
        // Act
        let subject = SubjectInt.init(raw: intValue)
        
        // Assert
        XCTAssertEqual(subject, .caseNo2)
    }
    
    func testInitializingWithCustomInitFromLiteralStringSucceeds(){
        XCTAssertEqual(SubjectString(raw: "case1"), .caseNo1)
    }
    func testInitializingWithCustomInitFromLiteralIntSucceeds(){
        XCTAssertEqual(SubjectInt(raw: 200), .caseNo2)
    }
    
    func testStringRawCreatesFromGraphemeLiteral(){
        // Arrange
        let stringRaw = EnumListStringRaw<SubjectString.Values>(extendedGraphemeClusterLiteral: "case1")
        
        // Act
        let subject = SubjectString(rawValue: stringRaw)
        
        // Assert
        XCTAssertEqual(subject, .caseNo1)
    }
    func testStringRawCreatesFromUnicodeLiteral(){
        // Arrange
        let stringRaw = EnumListStringRaw<SubjectString.Values>(unicodeScalarLiteral: "case1")
        
        // Act
        let subject = SubjectString(rawValue: stringRaw)
        
        // Assert
        XCTAssertEqual(subject, .caseNo1)
    }
    
    func testAllStringEnumsExistInAllList(){
        // Arrange
        
        // Act
        SubjectString.Values.initialize()
        let allValues = SubjectString.Values.all
        // Assert
        XCTAssertEqual(allValues, Set([.caseNo1, .caseNo2]))
    }
    
    func testAllRawStringValuesExistInAllRaws(){
        // Arrange
        
        // Act
        _ = SubjectString.Values.all
        let allRaws = SubjectString.Values.allRaws
        // Assert
        XCTAssertEqual(allRaws, Set(["case1", "case2"]))
    }
    
    func testNotCallingAllBeforeAskingForAllRawsReturnsEmptySet(){
        enum PrivateSubject: EnumListStringRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:StringEnumValues {
                typealias Element = PrivateSubject
                
                static var allRaws:Set<String> = []
            }
            
            case caseNo1 = "case1"
            case caseNo2 = "case2"
        }
        
        // Arrange
        
        // Act
        let allRaws = PrivateSubject.Values.allRaws
        // Assert
        XCTAssertTrue(allRaws.isEmpty)
    }
    
    func testFetchingNonExistingEnumFillsAllRawsSet(){
        enum PrivateSubject: EnumListStringRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:StringEnumValues {
                typealias Element = PrivateSubject
                
                static var allRaws:Set<String> = []
            }
            
            case caseNo1 = "case1"
            case caseNo2 = "case2"
        }
        
        // Arrange
        let raw:EnumListStringRaw<PrivateSubject.Values> = "some_none_existing_raw"
        // Act
        _ = PrivateSubject(rawValue: raw)
        
        // Assert
        let allRaws = PrivateSubject.Values.allRaws
        XCTAssertFalse(allRaws.isEmpty)
    }
    
    func testComparingDifferentEnumListRawsDoesNotModifyRawsSet(){
        enum PrivateSubject: EnumListStringRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:StringEnumValues {
                typealias Element = PrivateSubject
                
                static var allRaws:Set<String> = []
            }
            
            case caseNo1 = "case1"
            case caseNo2 = "case2"
        }
        
        // Arrange
        let raw:EnumListStringRaw<PrivateSubject.Values> = "some_none_existing_raw"
        // Act
        _ = PrivateSubject.caseNo1.rawValue == raw
        
        // Assert
        let allRaws = PrivateSubject.Values.allRaws
        XCTAssertFalse(allRaws.isEmpty)
    }
    
    func testAskingForInitializationFillsAllRawsSet(){
        enum PrivateSubject: EnumListStringRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:StringEnumValues {
                typealias Element = PrivateSubject
                
                static var allRaws:Set<String> = []
            }
            
            case caseNo1 = "case1"
            case caseNo2 = "case2"
        }
        
        // Arrange
        
        // Act
        PrivateSubject.Values.initialize()
        
        // Assert
        let allRaws = PrivateSubject.Values.allRaws
        XCTAssertFalse(allRaws.isEmpty)
    }
    
    
    func testAllIntEnumsExistInAllList(){
        // Arrange
        
        // Act
        let allValues = SubjectInt.Values.all
        // Assert
        XCTAssertEqual(allValues, Set([.caseNo1, .caseNo2]))
    }
    
    func testAllRawIntValuesExistInAllRaws(){
        // Arrange
        
        // Act
        _ = SubjectInt.Values.all
        let allRaws = SubjectInt.Values.allRaws
        // Assert
        XCTAssertEqual(allRaws, Set([1, 200]))
    }
    
    func testStringInitializationClearsASet(){
        // Arrange
        SubjectString.Values.allRaws = ["X"]
        
        // Act
        SubjectString.Values.initialize()
        
        // Assert
        let allRaws = SubjectString.Values.allRaws
        XCTAssertEqual(allRaws, Set(["case1", "case2"]))
    }
    
    func testIntInitializationClearsASet(){
        // Arrange
        SubjectInt.Values.allRaws = [111]
        
        // Act
        SubjectInt.Values.initialize()
        
        // Assert
        let allRaws = SubjectInt.Values.allRaws
        XCTAssertEqual(allRaws, Set([1,200]))
    }
    
    func testStringableSetReturnedIsCreatedFromScratch(){
        // Arrange
        SubjectString.Values.allRaws = ["X"]
        
        // Act
        
        // Assert
        let allRaws = SubjectString.Values.all
        XCTAssertEqual(allRaws, Set([.caseNo1, .caseNo2]))
    }
    
    func testInterableSetReturnedIsCreatedFromScratch(){
        // Arrange
        SubjectInt.Values.allRaws = [111]
        
        // Act
        
        // Assert
        let allRaws = SubjectInt.Values.all
        XCTAssertEqual(allRaws, Set([.caseNo1, .caseNo2]))
    }
    
    
    func testAllValuesForEnumWithDefaultStringVariableAreValid(){
        XCTAssertEqual(SubjectStringDefaultValue.Values.all, [.caseNo1, .caseNo2])
    }
    func testAllRawValuesForEnumWithDefaultStringVariableAreValid(){
        // Arrange
        SubjectStringDefaultValue.Values.initialize();
        // Act
        XCTAssertEqual(SubjectStringDefaultValue.Values.allRaws, ["caseNo1", "case2"])
    }
    
}
