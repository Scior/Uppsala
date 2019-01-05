//
//  UpdateDetailJSONEntityTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

fileprivate struct Constants {
    public static let testVersion = "1.1.12"
}

class UpdateDetailJSONEntityTests: XCTestCase {

    func testFromShouldSucceed() {
        let data = """
        {
            "version": "1.1.12"
        }
        """.data(using: .utf8)!
        
        guard let updateDetail = try? UpdateDetailJSONEntity.from(data: data) else {
            XCTFail("Decode failed")
            return
        }
        
        XCTAssertEqual(updateDetail.version, Constants.testVersion)
    }
    
    func testFromShouldFail() {
        let data = """
        {
            "versaaion": "1.1.12"
        }
        """.data(using: .utf8)!
        
        guard let _ = try? UpdateDetailJSONEntity.from(data: data) else {
            return
        }
        
        XCTFail("Decode succeeded")
    }

}
