//
//  UpdateDetailTests.swift
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

class UpdateDetailTests: XCTestCase {

    func testFromShouldSucceed() {
        let data = """
        {
            "version": "1.1.12"
        }
        """.data(using: .utf8)!
        
        guard let updateDetail = try? UpdateDetail.from(data: data) else {
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
        
        guard let _ = try? UpdateDetail.from(data: data) else {
            return
        }
        
        XCTFail("Decode succeeded")
    }

}
