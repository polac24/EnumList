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
    
    
    func testAllStringEnumsExistInAllList(){
        // Arrange
        
        // Act
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
        
        // Act
        _ = PrivateSubject(rawValue: EnumListRaw<PrivateSubject.Values> ())
        
        // Assert
        let allRaws = PrivateSubject.Values.allRaws
        XCTAssertFalse(allRaws.isEmpty)
    }
    
    func testAskingForAllEnumsFillsAllRawsSet(){
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
        _ = PrivateSubject.Values.all
        
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
