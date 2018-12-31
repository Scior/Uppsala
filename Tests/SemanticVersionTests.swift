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
    
    func testCount() {
        let version = "1.22.34.5"
        
        XCTAssertEqual(SemanticVersion(from: version)?.count, 4)
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
    
    func testEqualOperatorReturnsTrue() {
        let version1 = SemanticVersion(from: "1.22.35.5")!
        let version2 = SemanticVersion(from: "1.22.35.5")!
        
        XCTAssertEqual(version1, version2)
    }
    
    func testEqualOperatorReturnsFalse() {
        let version1 = SemanticVersion(from: "1.22.35.5")!
        let version2 = SemanticVersion(from: "1.22.35.4")!
        
        XCTAssertNotEqual(version1, version2)
    }

}
