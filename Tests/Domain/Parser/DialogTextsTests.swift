//
//  DialogTextsTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/02/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

fileprivate struct Constants {
    static let testTitle = "Hoge Title"
    static let testMessage = "update plz plz plz:)"
}

class DialogTextsTests: XCTestCase {

    func testInitializeWithExplicitStrings() {
        let texts = DialogTexts(title: Constants.testTitle, message: Constants.testMessage)
        
        XCTAssertEqual(texts.title, Constants.testTitle)
        XCTAssertEqual(texts.message, Constants.testMessage)
    }
    
    func testInitializeWithNilArguments() {
        let texts = DialogTexts(title: nil, message: nil)
        
        XCTAssertEqual(texts.title, "Update Notification")
        XCTAssertEqual(texts.message, "The new version is now available!")
    }

}
