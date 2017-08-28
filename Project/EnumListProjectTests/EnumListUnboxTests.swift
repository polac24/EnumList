//
//  EnumListUnboxTests.swift
//  EnumListProject
//
//  Created by Bartosz Polaczyk on 12/08/2017.
//  Copyright © 2017 Bartosz Polaczyk. All rights reserved.
//

import XCTest
import EnumList
import Unbox

class EnumListUnboxTests: XCTestCase {
    
    private enum SubjectString: EnumListStringRaw<SubjectString.Values>, RawRepresentable, UnboxableEnum{
        struct Values:StringEnumValues {
            typealias Element = SubjectString
            
            static var allRaws:Set<String> = []
        }
        
        case caseNo1 = "case1"
        case caseNo2 = "case2"
    }
    
    private enum SubjectInt: EnumListIntRaw<SubjectInt.Values>, RawRepresentable, UnboxableEnum{
        struct Values:IntEnumValues {
            typealias Element = SubjectInt
            
            static var allRaws:Set<Int> = []
        }
        
        case caseNo1 = 1
        case caseNo2 = 200
    }
    
    
    func testUnboxingDoesNotBreakListingAllsEnums() throws {
        // Arrange
        let dictionary:[String:Any] = ["data":"case1"]
        let a = Unboxer(dictionary:dictionary)
        let _:SubjectString = try a.unbox(key: "data")
        
        // Act
        SubjectString.Values.initialize()
        let all = SubjectString.Values.all
        
        // Assert
        XCTAssertEqual(all, [.caseNo1, .caseNo2])
    }
    
    func testUnboxingStringFindsEnum() throws {
        // Arrange
        let dictionary:[String:Any] = ["data":"case1"]
        
        // Act
        let a = Unboxer(dictionary:dictionary)
        let unboxed:SubjectString = try a.unbox(key: "data")
        
        // Assert
        XCTAssertEqual(unboxed, .caseNo1)
    }
    
    func testUnboxingStringFailsForIntValueInDict() throws {
        // Arrange
        let dictionary:[String:Any] = ["data":1]
        
        // Act
        let a = Unboxer(dictionary:dictionary)
        let unboxed:SubjectString? = try? a.unbox(key: "data")
        
        // Assert
        XCTAssertNil(unboxed)
    }
    
    func testUnboxingIntEnumSucceeds() throws {
        // Arrange
        let dictionary:[String:Any] = ["data":1]
        
        // Act
        let a = Unboxer(dictionary:dictionary)
        let unboxed:SubjectInt = try a.unbox(key: "data")
        
        // Assert
        XCTAssertEqual(unboxed, .caseNo1)
    }
    
    func testUnboxingSecondIntEnumSucceeds() throws {
        // Arrange
        let dictionary:[String:Any] = ["data":200]
        
        // Act
        let a = Unboxer(dictionary:dictionary)
        let unboxed:SubjectInt = try a.unbox(key: "data")
        
        // Assert
        XCTAssertEqual(unboxed, .caseNo2)
    }
    
    func testUnboxingIntEnumFromUnknownValueFails() throws {
        // Arrange
        let dictionary:[String:Any] = ["data":-1]
        
        // Act
        let a = Unboxer(dictionary:dictionary)
        let unboxed:SubjectInt? = try? a.unbox(key: "data")
        
        // Assert
        XCTAssertNil(unboxed)
    }
    
    func testUnboxingIntEnumFromStringFails() throws {
        // Arrange
        let dictionary:[String:Any] = ["data":"1"]
        
        // Act
        let a = Unboxer(dictionary:dictionary)
        let unboxed:SubjectInt? = try? a.unbox(key: "data")
        
        // Assert
        XCTAssertNil(unboxed)
    }
}
