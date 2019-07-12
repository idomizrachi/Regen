//
//  ArgumentsParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

//enum Language: String {
//    case objc
//    case swift
//}


class ArgumentsParser {
    
//    static let imagesType = "images"
//    static let localizationType = "localization"

    let arguments : [String]

    let operationType: OperationType
    
//    var output : String?
//    var language: Language = .ObjC
//    var verbose:Bool = false
//    var color:Bool = true

    init(arguments : [String]) {
        self.arguments = arguments
        self.operationType = ArgumentsParser.parseOperationType(arguments: arguments)
//        parseOutput()
//        parseLanguage()
//        parseVerbose()
//        parseColor()
    }

    private static func parseOperationType(arguments: [String]) -> OperationType  {
        if let localizationParameters = parseLocalizationParameters(arguments) {
            return .localization(parameters: localizationParameters)
        } else if let imagesParameters = parseImagesParameters(arguments) {
            return .images(parameters: imagesParameters)
        } else if isVersionOperation(arguments) {
            return .version
        } else {
            return .usage
        }
    }

    private static func parseLocalizationParameters(_ arguments: [String]) -> Localization.Parameters? {
        guard let firstArgument = arguments.first else {
            return nil
        }
        guard let operationType = OperationTypeKeys(rawValue: firstArgument) else {
            return nil
        }
        guard operationType == .localization else {
            return nil
        }
        guard let searchPath = parseSearchPath(arguments: arguments) else {
            return nil
        }
        guard let templateFilepath = parseTemplateFilepath(arguments: arguments) else {
            return nil
        }
        guard let outputFilename = parseOutputFilename(arguments: arguments) else {
            return nil
        }
        guard let outputClassName = parseOutputClassName(arguments: arguments) else {
            return nil
        }
        guard let baseLanguageCode = parseBaseLanguageCode(arguments: arguments) else {
            return nil
        }

        return Localization.Parameters(searchPath: searchPath, templateFilepath: templateFilepath, outputFilename: outputFilename, outputClassName: outputClassName, baseLanguageCode: baseLanguageCode)
    }

    private static func parseImagesParameters(_ arguments: [String]) -> ImagesParameters? {
        guard let firstArgument = arguments.first else {
            return nil
        }
        guard let operationType = OperationTypeKeys(rawValue: firstArgument) else {
            return nil
        }
        guard operationType == .images else {
            return nil
        }
        guard let templateFilepath = parseTemplateFilepath(arguments: arguments) else {
            return nil
        }
        guard let outputFilename = parseOutputFilename(arguments: arguments) else {
            return nil
        }
        return ImagesParameters(templateFilepath: templateFilepath, outputFilename: outputFilename)
    }


    private static func parseTemplateFilepath(arguments: [String]) -> String? {
        if let index = arguments.firstIndex(of: "--template"), index+1 < arguments.count {
            return arguments[index+1]
        } else {
            return nil
        }
    }

    private static func parseOutputFilename(arguments: [String]) -> String? {
        if let index = arguments.firstIndex(of: "--output-filename"), index+1 < arguments.count {
            return arguments[index+1]
        } else {
            return nil
        }
    }


    private static func parseOutputClassName(arguments: [String]) -> String? {
        if let index = arguments.firstIndex(of: "--output-class-name"), index+1 < arguments.count {
            return arguments[index+1]
        } else {
            return nil
        }
    }


    private static func parseSearchPath(arguments: [String]) -> String? {
        if let index = arguments.firstIndex(of: "--search-path"), index+1 < arguments.count {
            return arguments[index+1]
        } else {
            return nil
        }
    }

    private static func parseBaseLanguageCode(arguments: [String]) -> String? {
        if let index = arguments.firstIndex(of: "--base-language-code"), index+1 < arguments.count {
            return arguments[index+1]
        } else {
            return nil
        }
    }



    private static func isVersionOperation(_ arguments: [String]) -> Bool {
        guard let firstArgument = arguments.first else {
            return false
        }
        return firstArgument.lowercased() == OperationTypeKeys.version.rawValue
    }

    
//    func operationType() -> OperationType {
//        if isVersionOperationType() {
//            return .version
//        }
//        if isImagesOperationType() {
//            return .images
//        }
//        if isLocalizationOperationType() {
//            return .localization
//        }
//        return .usage
//    }
//
//    func isVersionOperationType() -> Bool {
//        //The first argument contains the executable file path
//        if arguments.contains("--version") && arguments.count == 2 {
//            return true
//        }
//        return false
//    }
//
//    func scanType() -> String? {
//        guard let indexOfScanType = arguments.index(of: "--scanType") else {
//            return nil
//        }
//        if indexOfScanType+1 < arguments.count {
//            let scanType = arguments[indexOfScanType+1]
//            return scanType.lowercased()
//        }
//        return nil
//    }
//
//
//    func isImagesOperationType() -> Bool {
//        if let scanType = scanType() {
//            if scanType == "images" {
//                return true
//            }
//        }
//        return false
//    }
//
//    func isLocalizationOperationType() -> Bool {
//        if let scanType = scanType() {
//            if scanType == "localization" {
//                return true
//            }
//        }
//        return false
//    }
//
//    func parseOutput() {
//        guard let indexOfOutput = arguments.index(of: "--output") else {
//            return
//        }
//        if indexOfOutput+1 < arguments.count {
//            self.output = arguments[indexOfOutput+1]
//        }
//    }
//
//    func parseLanguage() {
//        guard let indexOfLanguage = arguments.index(of: "--language") else {
//            return
//        }
//        if indexOfLanguage+1 < arguments.count {
//            let language = arguments[indexOfLanguage+1].lowercased()
//            if (language == "swift") {
//                self.language = .Swift
//            } else {
//                self.language = .ObjC
//            }
//        }
//    }
//
//    func parseVerbose() {
//        if arguments.index(of: "--verbose") != nil {
//            self.verbose = true
//        } else if arguments.index(of: "-v") != nil {
//            self.verbose = true
//        } else {
//            self.verbose = false
//        }
//    }
//
//    func parseColor() {
//        if arguments.index(of: "--nocolor") != nil {
//            self.color = false
//        } else {
//            self.color = true
//        }
//    }

}


