//
//  EnumListProjectTests.swift
//  EnumListProjectTests
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//  Copyright © 2017 Bartosz Polaczyk. All rights reserved.
//

import XCTest
import EnumList

class EnumListProjectTests: XCTestCase {
    
    private enum SubjectString: EnumListRaw<SubjectString.Values>, RawRepresentable{
        struct Values:EnumValues {
            typealias Element = SubjectString
            
            static var allRaws:Set<String> = []
        }
        
        case caseNo1 = "case1"
        case caseNo2 = "case2"
    }
    
    private enum SubjectInt: EnumListRaw<SubjectInt.Values>, RawRepresentable{
        struct Values:EnumValues {
            typealias Element = SubjectInt
            
            static var allRaws:Set<Int> = []
        }
        
        case caseNo1 = 1
        case caseNo2 = 200
    }
    
    
    let initializationCode:Void = {
        SubjectInt.Values.initialize()
        SubjectString.Values.initialize()
    }()
    
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
        enum PrivateSubject: EnumListRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:EnumValues {
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
        enum PrivateSubject: EnumListRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:EnumValues {
                typealias Element = PrivateSubject
                
                static var allRaws:Set<String> = []
            }
            
            case caseNo1 = "case1"
            case caseNo2 = "case2"
        }
        
        // Arrange
        let raw:EnumListRaw<PrivateSubject.Values> = "some_none_existing_raw"
        // Act
        _ = PrivateSubject(rawValue: raw)
        
        // Assert
        let allRaws = PrivateSubject.Values.allRaws
        XCTAssertFalse(allRaws.isEmpty)
    }
    
    func testComparingDifferentEnumListRawsDoesNotModifyRawsSet(){
        enum PrivateSubject: EnumListRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:EnumValues {
                typealias Element = PrivateSubject
                
                static var allRaws:Set<String> = []
            }
            
            case caseNo1 = "case1"
            case caseNo2 = "case2"
        }
        
        // Arrange
        let raw:EnumListRaw<PrivateSubject.Values> = "some_none_existing_raw"
        // Act
        _ = PrivateSubject.caseNo1.rawValue == raw
        
        // Assert
        let allRaws = PrivateSubject.Values.allRaws
        XCTAssertFalse(allRaws.isEmpty)
    }
    
    func testAskingForInitializationFillsAllRawsSet(){
        enum PrivateSubject: EnumListRaw<PrivateSubject.Values>, RawRepresentable{
            struct Values:EnumValues {
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
    
   
    
}
