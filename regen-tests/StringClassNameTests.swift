//
//  StringClassNameTests.swift
//  regen-tests
//
//  Created by Ido Mizrachi on 24/07/2019.
//  Copyright © 2019 Ido Mizrachi. All rights reserved.
//

import XCTest

class StringClassNameTests: XCTestCase {

    func testConvertToClassName() {
        let text = "helloThere"
        XCTAssertEqual(text.className(), "HelloThere")
    }

    func testEmptyString() {
        let text = ""
        XCTAssertEqual(text.className(), "")
    }

    func testAlreadyCapitalizedString() {
        let text = "HOLYSheep"
        XCTAssertEqual(text.className(), "HOLYSheep")
    }

}
