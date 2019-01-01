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
        
        public var mockVersion: String? = Constants.testVersionString
        
        func fetchShortVersion() -> String? {
            return mockVersion
        }
    }

    func testInitializer() {
        let environment = Environment(source: EnvironmentSourceMock())
        
        XCTAssertEqual(environment.appShortVersion, SemanticVersion(from: Constants.testVersionString))
    }
    
    func testInitializerWithNilShortVersion() {
        let mockSource = EnvironmentSourceMock()
        mockSource.mockVersion = nil
        let environment = Environment(source: mockSource)
        
        XCTAssertNil(environment.appShortVersion)
    }

}
