//
//  ArgumentsParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

enum Language {
    case ObjC
    case Swift
}

class ArgumentsParser {
    
    static let imagesType = "images"
    static let localizationType = "localization"
    
    let arguments : [String]
    
    var output : String?
    var language: Language = .ObjC
    var verbose:Bool = false
    var color:Bool = true
    
    init(arguments : [String]) {
        self.arguments = arguments
        parseOutput()
        parseLanguage()
        parseVerbose()
        parseColor()
    }
    
    func operationType() -> OperationType {
        if isVersionOperationType() {
            return .version
        }
        if isImagesOperationType() {
            return .images
        }
        if isLocalizationOperationType() {
            return .localization
        }
        return .usage
    }
    
    func isVersionOperationType() -> Bool {
        //The first argument contains the executable file path
        if arguments.contains("--version") && arguments.count == 2 {
            return true
        }
        return false
    }
    
    func scanType() -> String? {
        guard let indexOfScanType = arguments.index(of: "--scanType") else {
            return nil
        }
        if indexOfScanType+1 < arguments.count {
            let scanType = arguments[indexOfScanType+1]
            return scanType.lowercased()
        }
        return nil
    }
    
    
    func isImagesOperationType() -> Bool {
        if let scanType = scanType() {
            if scanType == "images" {
                return true
            }
        }
        return false
    }
    
    func isLocalizationOperationType() -> Bool {
        if let scanType = scanType() {
            if scanType == "localization" {
                return true
            }
        }
        return false
    }
    
    func parseOutput() {
        guard let indexOfOutput = arguments.index(of: "--output") else {
            return
        }
        if indexOfOutput+1 < arguments.count {
            self.output = arguments[indexOfOutput+1]
        }
    }
    
    func parseLanguage() {
        guard let indexOfLanguage = arguments.index(of: "--language") else {
            return
        }
        if indexOfLanguage+1 < arguments.count {
            let language = arguments[indexOfLanguage+1].lowercased()
            if (language == "swift") {
                self.language = .Swift
            } else {
                self.language = .ObjC
            }
        }
    }
    
    func parseVerbose() {
        if arguments.index(of: "--verbose") != nil {
            self.verbose = true
        } else if arguments.index(of: "-v") != nil {
            self.verbose = true
        } else {
            self.verbose = false
        }
    }
    
    func parseColor() {
        if arguments.index(of: "--nocolor") != nil {
            self.color = false
        } else {
            self.color = true
        }
    }
    
}


