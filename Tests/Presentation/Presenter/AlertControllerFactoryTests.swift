//
//  AlertControllerFactoryTests.swift
//  UppsalaTests
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import XCTest
@testable import Uppsala

fileprivate struct Constants {
    public static let testAlertControllerTitle = "Hoge"
    public static let testAlertControllerMessage = "Test message hoge"
    public static let testAppStoreButtonTitle = "Test Store"
    public static let testAppStoreButtonURL = "https://hogehoge.com/"
    public static let testLinkButtonTitle = "Test Link"
    public static let testLinkButtonURL = "https://hugahuga.com/"
    public static let testCloseButtonTitle = "Test Close"
}

class AlertControllerFactoryTests: XCTestCase {

    func testBuildWithAllDefaultActionsShouldHaveCorrectTitles() {
        let factory = AlertControllerFactory(texts: DialogTexts(title: Constants.testAlertControllerTitle, message: Constants.testAlertControllerTitle))
        factory.actions = [
            .openAppStore(title: Constants.testAppStoreButtonTitle, url: URL(string: Constants.testAppStoreButtonURL)!),
            .openLink(title: Constants.testLinkButtonTitle, url: URL(string: Constants.testLinkButtonURL)!),
            .close(title: Constants.testCloseButtonTitle)
        ]
        let controller = factory.build()
        
        XCTAssertEqual(controller.actions.count, 3)
        
        let actionTitles = controller.actions.compactMap({$0.title})
        XCTAssert(actionTitles.contains(Constants.testAppStoreButtonTitle))
        XCTAssert(actionTitles.contains(Constants.testLinkButtonTitle))
        XCTAssert(actionTitles.contains(Constants.testCloseButtonTitle))
    }

}
