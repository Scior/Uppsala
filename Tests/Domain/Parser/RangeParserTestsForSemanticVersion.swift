//
//  RangeParserTestsForSemanticVersion.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

class RangeParserTestsForSemanticVersion: XCTestCase {
    
    let parser = RangeParser()

    func testParseWithBothDefinedRange() {
        let parseResult = parser.parse(from: "0.1.1 < 1.2", to: SemanticVersion.self)
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
    
    func testParseWithBothDefinedRangeWithEqual() {
        let parseResult = parser.parse(from: "0.1.1 <= 1.2", to: SemanticVersion.self)
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
        XCTAssert(range.contains(SemanticVersion(from: "1.2")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.2.0")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.2.0.1")!))
    }
    
    func testParseWithRightDefinedRange() {
        let parseResult = parser.parse(from: "<2.0", to: SemanticVersion.self)
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
    
    func testParseWithRightDefinedRangeWithEqual() {
        let parseResult = parser.parse(from: "<=2.0", to: SemanticVersion.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(SemanticVersion(from: "1.12")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.12.1")!))
        XCTAssert(range.contains(SemanticVersion(from: "2")!))
        XCTAssert(range.contains(SemanticVersion(from: "2.0")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "2.0.1")!))
    }
    
    func testParseWithSingleValue() {
        let parseResult = parser.parse(from: "1.12", to: SemanticVersion.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(SemanticVersion(from: "1.12")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.12.0")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.12.0.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.12.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "2")!))
    }
    
    func testParseWithSingleValueWithEqual() {
        let parseResult = parser.parse(from: "=1.12", to: SemanticVersion.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(SemanticVersion(from: "1.12")!))
        XCTAssert(range.contains(SemanticVersion(from: "1.12.0")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.12.0.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "1.12.1")!))
        XCTAssertFalse(range.contains(SemanticVersion(from: "2")!))
    }
    
    func testParseWithInvalidRangeFormat() {
        let parseResult = parser.parse(from: "<<2.2", to: SemanticVersion.self)
        guard let error = parseResult.error() else {
            XCTFail("\(parseResult.ok()!)")
            return
        }
        
        switch error {
        case .invalidRangeFormat:
            break
        default:
            XCTFail("Unexpected error returned")
        }
    }
    
    func testParseWithInvalidRangeFormat2() {
        let parseResult = parser.parse(from: "1.0<1.1<2.2", to: SemanticVersion.self)
        guard let error = parseResult.error() else {
            XCTFail("\(parseResult.ok()!)")
            return
        }
        
        switch error {
        case .invalidRangeFormat:
            break
        default:
            XCTFail("Unexpected error returned")
        }
    }
    
    func testParseWithInvalidValueFormat() {
        let parseResult = parser.parse(from: "1.1...<2.2", to: SemanticVersion.self)
        guard let error = parseResult.error() else {
            XCTFail("\(parseResult.ok()!)")
            return
        }
        
        switch error {
        case .invalidValueFormat:
            break
        default:
            XCTFail("Unexpected error returned")
        }
    }

}
