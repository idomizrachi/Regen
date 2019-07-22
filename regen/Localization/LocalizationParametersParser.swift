//
//  LocalizationParametersParser.swift
//  regen
//
//  Created by Ido Mizrachi on 17/07/2019.
//  Copyright © 2019 Ido Mizrachi. All rights reserved.
//

import Foundation

class LocalizationParametersParser {
    let arguments: [String]

    init(arguments: [String]) {
        self.arguments = arguments
    }

    func parse() -> Localization.Parameters? {
        guard let searchPath: String = tryParse(.searchPath, from: arguments) else {
            return nil
        }
        guard let templateFile: String = tryParse(.template, from: arguments) else {
            return nil
        }
        let outputFilename: String = tryParse(.outputFilename, from: arguments) ?? "Localization.swift"
        let outputClassName: String = tryParse(.outputClassName, from: arguments) ?? "Localization"
        let baseLanguageCode: String = tryParse(.baseLanguageCode, from: arguments) ?? "en"
        let whitelistFile: String? = tryParse(.whitelist, from: arguments)
        let parameterDetection: Localization.ParameterDetection?
        if
            let startRegex: String = tryParse(.parameterStartRegex, from: arguments),
            let endRegex: String = tryParse(.parameterEndRegex, from: arguments),
            let startOffset: Int = tryParse(.parameterStartOffset, from: arguments),
            let endOffset: Int = tryParse(.parameterEndOffset, from: arguments) {
            parameterDetection = Localization.ParameterDetection(startRegex: startRegex, endRegex: endRegex, startOffset: startOffset, endOffset: endOffset)
        } else {
            parameterDetection = nil
        }
        return Localization.Parameters(searchPath: searchPath, templateFile: templateFile, outputFilename: outputFilename, outputClassName: outputClassName, baseLanguageCode: baseLanguageCode, parameterDetection: parameterDetection, whitelistFile: whitelistFile)
    }

    //TODO: Move to a more general location
    func tryParse<T: CanBeInitializedWithString>(_ parameter: CommandLineParameter, from arguments: [String]) -> T? {
        if let index = arguments.firstIndex(of: parameter.rawValue), index+1 < arguments.count {
            return T(arguments[index+1])
        } else {
            return nil
        }
    }

}
