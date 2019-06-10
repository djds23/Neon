//
//  ParsedTextTest.swift
//  NeonTests
//
//  Created by Dean Silfen on 6/9/19.
//  Copyright © 2019 Dean Silfen. All rights reserved.
//

import Neon
import XCTest

let testFixture = """
NYT Cooking: Gochujang Barbecue Ribs With Peanuts and Scallions

https://cooking.nytimes.com/recipes/1018796-gochujang-barbecue-ribs-with-peanuts-and-scallions?utm_source=sharetools&utm_medium=email&utm_campaign=website
"""

class ParsedTextTest: XCTestCase {
    func testParse() {
        let parsedText = ParsedText(text: testFixture)
        XCTAssertEqual(parsedText.matches.count, 1)
    }
}
