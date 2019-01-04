//
//  SemanticVersionRangeParserTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

class SemanticVersionRangeParserTests: XCTestCase {

    func testParseWithBothDefinedRange() {
        let parseResult = SemanticVersionRangeParser.parse(from: "0.1.1 < 1.2")
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(SemanticVersion(from: "0.1.1.1")!))
        XCTAssert(range.contains(SemanticVersion(from: "0.1.1")!))
        XCTAssert(range.contains(SemanticVersion(from: "0.1.1.0")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "0.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "0.0.1")!))
        
        XCTAssert(range.contains(SemanticVersion(from: "1.1")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.1.12")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.2")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.2.0")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.2.0.1")!))
    }
    
    func testParseWithRightDefinedRange() {
        let parseResult = SemanticVersionRangeParser.parse(from: "<2.0")
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(SemanticVersion(from: "1.12")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.12.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "2")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "2.0")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "2.0.1")!))
    }
    
    func testParseWithSingleValue() {
        let parseResult = SemanticVersionRangeParser.parse(from: "1.12")
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(SemanticVersion(from: "1.12")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.12.0")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.12.0.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.12.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "2")!))
    }
    
    func testParseWithInvalidFormat() {
        let parseResult = SemanticVersionRangeParser.parse(from: "+2.2")
        guard let error = parseResult.error() else {
            XCTFail("\(parseResult.ok()!)")
            return
        }
        
        switch error {
        case .invalidFormat:
            break
        default:
            XCTFail("Unexpected error returned")
        }
    }
    
    func testParseWithInvalidFormat2() {
        let parseResult = SemanticVersionRangeParser.parse(from: "1.0<1.1<2.2")
        guard let error = parseResult.error() else {
            XCTFail("\(parseResult.ok()!)")
            return
        }
        
        switch error {
        case .invalidFormat:
            break
        default:
            XCTFail("Unexpected error returned")
        }
    }
    
    func testParseWithInvalidVersionFormat() {
        let parseResult = SemanticVersionRangeParser.parse(from: "1.1...<2.2")
        guard let error = parseResult.error() else {
            XCTFail("\(parseResult.ok()!)")
            return
        }
        
        switch error {
        case .invalidVersionFormat:
            break
        default:
            XCTFail("Unexpected error returned")
        }
    }

}
