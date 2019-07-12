//
//  ArgumentsParserTests.swift
//  regen-tests
//
//  Created by Ido Mizrachi on 12/07/2019.
//  Copyright © 2019 Ido Mizrachi. All rights reserved.
//

import XCTest

class ArgumentsParserTests: XCTestCase {

    func testEmptyArguments() {
        let argumentsParser = ArgumentsParser(arguments: [])
        switch argumentsParser.operationType {
        case .usage: break
        default: XCTFail("Bad operation")
        }
    }
}

class ArgumentsParserLocalizationTests: XCTestCase {

    func testLocalizationOperationDefaultArguments() {
        let argumentsParser = ArgumentsParser(arguments: ["localization"])
        switch argumentsParser.operationType {
        case .usage: break
        default: XCTFail("Bad operation")
        }

    }

    func testLocalizationOperationWithMissingSearchPath() {
        let argumentsParser = ArgumentsParser(arguments: ["localization", "--template", "hello", "--output", "Gen.m"])
        switch argumentsParser.operationType {
        case .usage: break
        default: XCTFail("Bad operation")
        }
    }

    func testLocalizationOperationWithMissingOutput() {
        let argumentsParser = ArgumentsParser(arguments: ["localization", "--search-path", "hello", "--template", "hello"])
        switch argumentsParser.operationType {
        case .usage: break
        default: XCTFail("Bad operation")
        }
    }

    func testLocalizationOperationWithMissingTemplate() {
        let argumentsParser = ArgumentsParser(arguments: ["localization", "--output", "hello", "--search-path", "hello"])
        switch argumentsParser.operationType {
        case .usage: break
        default: XCTFail("Bad operation")
        }
    }

    

    func testLocalizationOperationWithValidParameters() {
        let argumentsParser = ArgumentsParser(arguments: ["localization", "--template", "hello", "--output", "Gen.swift", "--search-path", "Search Path", "--base-language-code", "he"])
        switch argumentsParser.operationType {
        case .localization(let parameters):
            XCTAssertEqual(parameters.templateFilepath, "hello")
            XCTAssertEqual(parameters.outputFilename, "Gen.swift")
            XCTAssertEqual(parameters.searchPath, "Search Path")
            XCTAssertEqual(parameters.baseLanguageCode, "he")
        default: XCTFail("Bad operation")
        }
    }
}


