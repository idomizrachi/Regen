//
//  ArgumentsParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class ArgumentsParser {
    
    static let imagesType = "images"
    static let localizationType = "localization"
    
    let arguments : [String]
    
    var output : String?
    
    init(arguments : [String]) {
        self.arguments = arguments
    }
    
    func operationType() -> OperationType {
        if isVersionOperationType() {
            return .Version
        }
        if isImagesOperationType() {
            return .Images
        }
        if isLocalizationOperationType() {
            return .Localization
        }
        return .Usage
    }
    
    func isVersionOperationType() -> Bool {
        //The first argument contains the executable file path
        if arguments.contains("--version") && arguments.count == 2 {
            return true
        }
        return false
    }
    
    func scanType() -> String? {
        guard let indexOfScanType = arguments.indexOf("--scanType") else {
            return nil
        }
        if indexOfScanType+1 < arguments.count {
            let scanType = arguments[indexOfScanType+1]
            return scanType.lowercaseString
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
        guard let indexOfOutput = arguments.indexOf("--output") else {
            return
        }
        if indexOfOutput+1 < arguments.count {
            self.output = arguments[indexOfOutput+1]
        }
    }
    
}


