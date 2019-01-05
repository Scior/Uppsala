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
    static let testVersion = "1.1.12"
}

class UpdateDetailJSONEntityTests: XCTestCase {

    func testFromShouldSucceed() {
        let data = """
        {
            "version": "1.1.12",
            "app_store_url": "https://www.apple.com"
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
            "version": "1.1.12"
        }
        """.data(using: .utf8)!
        
       
        XCTAssertThrowsError(try UpdateDetailJSONEntity.from(data: data))
        
    }

}
