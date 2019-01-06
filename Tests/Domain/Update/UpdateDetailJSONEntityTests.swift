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
    static let testTitle = "Update Sample"
    static let testMessage = "Hogeee"
    static let testVersion = "1.1.12"
}

class UpdateDetailJSONEntityTests: XCTestCase {

    func testFromShouldSucceedWithMinimumKeys() {
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
    
    
    func testFromShouldSucceedWithMaximumKeys() {
        let data = """
        {
            "app_store_url": "https://www.apple.com",
            "message": "\(Constants.testMessage)",
            "title": "\(Constants.testTitle)",
            "version": "1.1.12"
        }
        """.data(using: .utf8)!
        
        guard let updateDetail = try? UpdateDetailJSONEntity.from(data: data) else {
            XCTFail("Decode failed")
            return
        }
        
        XCTAssertEqual(updateDetail.version, Constants.testVersion)
        XCTAssertEqual(updateDetail.title, Constants.testTitle)
        XCTAssertEqual(updateDetail.message, Constants.testMessage)
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
