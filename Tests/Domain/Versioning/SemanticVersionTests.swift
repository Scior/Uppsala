//
//  SemanticVersionTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2018/12/31.
//  Copyright © 2018 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

class SemanticVersionTests: XCTestCase {

    func testInitializerWithValidString() {
        let version = "1.22.34.5"
        
        XCTAssertNotNil(SemanticVersion(from: version))
    }
    
    func testInitializerWithInvalidString() {
        let version = "1.22.34.5a"
        
        XCTAssertNil(SemanticVersion(from: version))
    }
    
    func testInitializerWithEmptyString() {
        let version1 = ""
        let version2 = "0"
        
        XCTAssertEqual(SemanticVersion(from: version1), SemanticVersion(from: version2))
    }
    
    func testCount() {
        let version = "1.22.34.5"
        
        XCTAssertEqual(SemanticVersion(from: version)?.count, 4)
    }
    
    func testDescription() {
        let version = SemanticVersion(from: "1.022.34.05")!
        
        XCTAssertEqual(version.description, "1.22.34.5")
    }
    
    func testComparisonOperator1() {
        let version1 = SemanticVersion(from: "1.22.34.5")!
        let version2 = SemanticVersion(from: "1.22.35.5")!
        
        XCTAssert(version1 < version2)
    }
    
    func testComparisonOperator2() {
        let version1 = SemanticVersion(from: "2.22.34.5")!
        let version2 = SemanticVersion(from: "1.22.35.5")!
        
        XCTAssert(version1 > version2)
    }
    
    func testComparisonOperator3() {
        let version1 = SemanticVersion(from: "1.22.35.5")!
        let version2 = SemanticVersion(from: "1.22.35.5")!
        
        XCTAssertFalse(version1 < version2)
        XCTAssertFalse(version1 > version2)
    }
    
    func testComparisonOperator4() {
        let version1 = SemanticVersion(from: "552.22.34.5")!
        let version2 = SemanticVersion(from: "80.23.35.6")!
        
        XCTAssert(version1 > version2)
    }
    
    func testEqualOperatorReturnsTrue1() {
        let version1 = SemanticVersion(from: "1.22.35.5")!
        let version2 = SemanticVersion(from: "1.22.35.5")!
        
        XCTAssertEqual(version1, version2)
    }
    
    func testEqualOperatorReturnsTrue2() {
        let version1 = SemanticVersion(from: "1.22.35.0")!
        let version2 = SemanticVersion(from: "1.22.35")!
        
        XCTAssertEqual(version1, version2)
    }
    
    func testEqualOperatorReturnsTrue3() {
        let version1 = SemanticVersion(from: "1.0.1")!
        let version2 = SemanticVersion(from: "1.0.1.0")!
        
        XCTAssertEqual(version1, version2)
    }
    
    func testEqualOperatorReturnsFalse1() {
        let version1 = SemanticVersion(from: "1.22.35.5")!
        let version2 = SemanticVersion(from: "1.22.35.4")!
        
        XCTAssertNotEqual(version1, version2)
    }
    
    func testEqualOperatorReturnsFalse2() {
        let version1 = SemanticVersion(from: "1.22.0.1")!
        let version2 = SemanticVersion(from: "1.22.0")!
        
        XCTAssertNotEqual(version1, version2)
    }

}
