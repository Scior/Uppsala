//
//  UpdateDetailJSONFetcherTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

class UpdateDetailJSONFetcherTests: XCTestCase {
    
    let testURL = Bundle(for: UpdateDetailJSONFetcherTests.self).url(forResource: "update_detail", withExtension: "json")!

    func testFetchShouldSucceed() {
        let expectation = XCTestExpectation(description: "Fetch succeeded")
        UpdateDetailJSONFetcher().fetch(from: testURL) { (result) in
            if let _ = result.ok() {
                expectation.fulfill()
            } else {
                XCTFail("Fetch failed")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
