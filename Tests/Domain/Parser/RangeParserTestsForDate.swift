//
//  RangeParserTestsForDate.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/06.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

class RangeParserTestsForDate: XCTestCase {

    let parser = RangeParser()
    
    func testParseWithBothDefinedRange() {
        let parseResult = parser.parse(from: "2018-11-11T00:00 < 2018-12-01T00:00", to: Date.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(Date.from("2018-11-11T00:00")!))
        XCTAssert(range.contains(Date.from("2018-11-12T00:00")!))
        XCTAssert(range.contains(Date.from("2018-11-30T00:00")!))
        XCTAssertFalse(range.contains(Date.from("2018-12-1T00:00")!))
        XCTAssertFalse(range.contains(Date.from("2019-1-1T00:00")!))
    }
    
    func testParseWithBothDefinedRangeWithEqual() {
        let parseResult = parser.parse(from: "2018-11-11T00:00 <=2018-12-01T00:00", to: Date.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(Date.from("2018-11-11T00:00")!))
        XCTAssert(range.contains(Date.from("2018-11-12T00:00")!))
        XCTAssert(range.contains(Date.from("2018-11-30T00:00")!))
        XCTAssert(range.contains(Date.from("2018-12-1T00:00")!))
        XCTAssertFalse(range.contains(Date.from("2018-12-1T00:01")!))
        XCTAssertFalse(range.contains(Date.from("2019-1-1T00:00")!))
    }
    
    func testParseWithRightDefinedRange() {
        let parseResult = parser.parse(from: "<2018-12-01T00:00", to: Date.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(Date.from("2015-10-10T00:00")!))
        XCTAssert(range.contains(Date.from("2018-11-12T00:00")!))
        XCTAssert(range.contains(Date.from("2018-11-30T00:00")!))
        XCTAssertFalse(range.contains(Date.from("2018-12-1T00:00")!))
        XCTAssertFalse(range.contains(Date.from("2019-1-1T00:00")!))
    }
    
    func testParseWithRightDefinedRangeWithEqual() {
        let parseResult = parser.parse(from: "<=2018-12-01T00:00", to: Date.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(Date.from("2015-10-10T00:00")!))
        XCTAssert(range.contains(Date.from("2018-11-12T00:00")!))
        XCTAssert(range.contains(Date.from("2018-12-1T00:00")!))
        XCTAssertFalse(range.contains(Date.from("2019-1-1T00:01")!))
        XCTAssertFalse(range.contains(Date.from("2019-1-1T00:00")!))
    }
    
    func testParseWithSingleValue() {
        let parseResult = parser.parse(from: "2019-01-01T09:00", to: Date.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }

        XCTAssert(range.contains(Date.from("2019-01-01T09:00")!))
        XCTAssertFalse(range.contains(Date.from("2019-01-02T09:01")!))
        XCTAssertFalse(range.contains(Date.from("2019-01-02T09:00")!))
    }
    
    func testParseWithSingleValueWithEqual() {
        let parseResult = parser.parse(from: "=2019-01-01T09:00", to: Date.self)
        guard let range = parseResult.ok() else {
            XCTFail("\(parseResult.error()!)")
            return
        }
        
        XCTAssert(range.contains(Date.from("2019-01-01T09:00")!))
        XCTAssertFalse(range.contains(Date.from("2019-01-02T09:01")!))
        XCTAssertFalse(range.contains(Date.from("2019-01-02T09:00")!))
    }
    
    func testParseWithInvalidRangeFormat() {
        let parseResult = parser.parse(from: "<<2018-12-01T00:00", to: Date.self)
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
        let parseResult = parser.parse(from: "2017-11-11T00:00<2018-11-11T00:00<2018-12-01T00:00", to: SemanticVersion.self)
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
        let parseResult = parser.parse(from: "2018/11/11T00:00<2018-12-01T00:00", to: SemanticVersion.self)
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
