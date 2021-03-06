//
//  UpdateDetailTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/05.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

fileprivate struct Constants {
    static let testAppStoreUrl = "https://www.apple.com"
    static let testVersion = "<=1.1.12"
    static let testInvalidVersion = "<1.1..12"
}

class UpdateDetailTests: XCTestCase {

    func testIntializerShouldSucceed() {
        let entity = UpdateDetailJSONEntity(appStoreUrl: Constants.testAppStoreUrl, message: nil, title: nil, version: Constants.testVersion)
        guard let updateDetail = try? UpdateDetail(from: entity) else {
            XCTFail("Unexpected nil")
            return
        }
        
        let expectedRange = UppsalaRange(lhs: nil, rhs: SemanticVersion(from: "1.1.12")!, isContainingRightSide: true)
        XCTAssertEqual(updateDetail.version, expectedRange)
    }
    
    func testIntializerShouldReturnNil() {
        let entity = UpdateDetailJSONEntity(appStoreUrl: Constants.testAppStoreUrl,  message: nil, title: nil, version: Constants.testInvalidVersion)
        let updateDetail = try? UpdateDetail(from: entity)
        
        XCTAssertNil(updateDetail)
    }

}
