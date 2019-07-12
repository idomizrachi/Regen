//
//  LocalizationParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

extension Localization {
    struct Entry: Codable {
        var path : String
        var key : String
        var value : String
        var property : String
    }

    class Parser {

        func parseLocalizationFile(_ file : String) -> [Entry] {
            var localizationEntries : [Entry] = []
            let content : String
            do {
                content = try String(contentsOfFile: file)
                let lines = content.components(separatedBy: "\n")
                for line in lines {
                    let keyValue = parseLocalizationLine(line)
                    if let key = keyValue.0, let value = keyValue.1 {
                        let property = key.propertyName()
                        localizationEntries.append(Entry(path: file, key: key, value: value, property: property))
                    }
                }
            } catch {
                content = ""
            }
            return localizationEntries
        }

        func appendEntries(_ from : [Entry], to : inout [Entry]) {
            for entry in from {
                if Localization.Parser.contains(to, key: entry.key) {
                    continue
                }
                to.append(entry)
            }
        }

        static func contains(_ entries : [Entry], key : String) -> Bool {
            for entry in entries {
                if entry.key == key {
                    return true
                }
            }
            return false
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
