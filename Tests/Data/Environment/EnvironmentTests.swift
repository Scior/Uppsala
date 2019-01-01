//
//  EnvironmentTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

fileprivate struct Constants {
    static let testVersionString = "1.0.12"
}

class EnvironmentTests: XCTestCase {
    
    class EnvironmentSourceMock: EnvironmentSource {
        func fetchShortVersion() -> String? {
            return Constants.testVersionString
        }
    }

    func testInitializer() {
        let environment = Environment(source: EnvironmentSourceMock())
        
        XCTAssertEqual(environment.appShortVersion, SemanticVersion(from: Constants.testVersionString))
    }

}
