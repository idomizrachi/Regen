//
//  ArgumentsParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

protocol CanBeInitializedWithString {
    init?(_ description: String)
}

extension Int: CanBeInitializedWithString {}
extension String: CanBeInitializedWithString {}

class ArgumentsParser {
    let arguments : [String]
    let operationType: OperationType

    init(arguments : [String]) {
        self.arguments = arguments
        self.operationType = ArgumentsParser.parseOperationType(arguments: arguments)
    }

    private static func parseOperationType(arguments: [String]) -> OperationType  {
        let operationTypeKey = parseOperationTypeKey(arguments)
        switch operationTypeKey {
        case .localization:
            guard let parameters = parseLocalizationParameters(arguments) else {
                return .usage
            }
            return .localization(parameters: parameters)
        case .images:
            guard let parameters = parseImagesParameters(arguments) else {
                return .usage
            }
            return .images(parameters: parameters)
        case .version:
            return .version
        case .usage:
            return .usage
        }
    }

    private static func parseOperationTypeKey(_ arguments: [String]) -> OperationType.Keys {
        guard let firstArgument = arguments.first else {
            return .usage
        }
        return OperationType.Keys(rawValue: firstArgument) ?? .usage
    }

    private static func parseLocalizationParameters(_ arguments: [String]) -> Localization.Parameters? {
        let parser = LocalizationParametersParser(arguments: arguments)
        return parser.parse()
    }

    private static func parseImagesParameters(_ arguments: [String]) -> Images.Parameters? {
        let parser = ImagesParametersParser(arguments: arguments)
        return parser.parse()
    }

//    private static func parseAssetsFile(arguments: [String]) -> String? {
//        let assetsFile: String? = tryParse("--assets-file", from: arguments)
//        return assetsFile
//    }

    private static func isVersionOperation(_ arguments: [String]) -> Bool {
        guard let firstArgument = arguments.first else {
            return false
        }
        return firstArgument.lowercased() == OperationType.Keys.version.rawValue
    }
}


