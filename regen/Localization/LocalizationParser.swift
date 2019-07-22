//
//  LocalizationParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

extension Localization {

    struct KeyValue: Codable {
        let key: String
        let value: String
    }

    struct Entry: Codable {
        let path : String
        let key : String
        let value : String
        let property : String
        let params: [KeyValue]
    }

    class Parser {
        let parameterDetection: ParameterDetection?
        let whitelist: [String]?

        init(parameterDetection: ParameterDetection?, whitelist: [String]?) {
            self.parameterDetection = parameterDetection
            self.whitelist = whitelist
        }

        func parseLocalizationFile(_ file : String) -> [Entry] {
            var localizationEntries : [Entry] = []
            let content : String
            do {
                content = try String(contentsOfFile: file)
                let lines = content.components(separatedBy: "\n")
                for line in lines {
                    let keyValue = parseLocalizationLine(line)
                    if let key = keyValue.0, let value = keyValue.1 {
                        if let whitelist = self.whitelist {
                            if !whitelist.contains(key) {
                                continue
                            }
                        }
                        let property = key.propertyName()
                        var params: [KeyValue] = []
                        if let parameterDetection = parameterDetection {
                            var range = value.startIndex..<value.endIndex
                            while let parameterRange = value.range(of: "(\(parameterDetection.startRegex))[^\(parameterDetection.startRegex)]+(\(parameterDetection.endRegex))", options: .regularExpression, range: range) {
                                let start = value.index(parameterRange.lowerBound, offsetBy: parameterDetection.startOffset)
                                let end = value.index(parameterRange.upperBound, offsetBy: -parameterDetection.endOffset)
                                let parameter = String(value[start..<end])
                                if !params.contains { $0.key == parameter.propertyName() } {
                                    params.append(KeyValue(key: parameter.propertyName(), value: parameter))
                                }
                                range = parameterRange.upperBound..<value.endIndex
                            }

                        }
                        localizationEntries.append(Entry(path: file, key: key, value: value, property: property, params: params))
                    }
                }
            } catch {
                content = ""
            }
            return localizationEntries
        }

        func parseLocalizationLine(_ line: String) -> (String?, String?) {
            var key:String = ""
            var value:String = ""
            let trimmedLine = line.trimmingCharacters(in: CharacterSet.whitespaces)
            guard trimmedLine.hasPrefix("\"") else {
                return (nil, nil)
            }
            var keyStarted = false
            var keyFinished = false
            var valueStarted = false
            var valueFinished = false
            var previousCharacter:Character = "\0"
            line.forEach { character in
                if character == "\"" {
                    if previousCharacter != "\\" {
                        if keyStarted == false && keyFinished == false {
                            keyStarted = true
                            return
                        }
                        if keyStarted == true && keyFinished == false {
                            keyFinished = true
                            return
                        }
                        if keyFinished == true && valueStarted == false {
                            valueStarted = true
                            return
                        }
                        if valueStarted == true && valueFinished == false {
                            valueFinished = true
                            return
                        }
                    }
                }
                if character == "#" && keyStarted == true && keyFinished == false {
                    keyFinished = true
                    return
                }
                if keyStarted == true && keyFinished == false {
                    key += String(character)
                }
                if valueStarted == true && valueFinished == false {
                    value += String(character)
                }
                previousCharacter = character
            }
            if keyStarted == true && keyFinished == true && valueStarted == true && valueFinished == true {
                return (key, value)
            } else {
                return (nil, nil)
            }
        }

    }
}
