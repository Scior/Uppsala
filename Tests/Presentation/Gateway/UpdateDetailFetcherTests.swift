//
//  UpdateDetailFetcherTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

class UpdateDetailFetcherTests: XCTestCase {
    
    let testURL = Bundle(for: UpdateDetailFetcherTests.self).url(forResource: "update_detail", withExtension: "json")!

    func testFetchShouldSucceed() {
        let expectation = XCTestExpectation(description: "fetch() succeeded")
        UpdateDetailFetcher().fetch(from: testURL) { (result) in
            if let _ = result.ok() {
                expectation.fulfill()
            } else {
                XCTFail("Fetch failed")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchAwaitShouldSucceed() {
        let result = UpdateDetailFetcher().fetchAwait(from: testURL)
        XCTAssert(result.isOk())
    }

}
