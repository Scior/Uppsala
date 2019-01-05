//
//  EnvironmentSourceAppTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

class EnvironmentSourceAppTests: XCTestCase {

    func testFetchShortVersion() {
        let environment = EnvironmentSourceApp()
        
        XCTAssertNil(environment.fetchShortVersion())
    }

}
