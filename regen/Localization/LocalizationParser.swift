//
//  LocalizationParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

struct LocalizationEntry {
    var path : String
    var key : String
    var value : String
    var property : String
}

class LocalizationParser {
    
    func parseLocalizationFile(_ file : String) -> [LocalizationEntry] {
        var localizationEntries : [LocalizationEntry] = []
        let content : String
        do {
            Logger.verbose("\t\tLoading localization file: started")
            content = try String(contentsOfFile: file)
            Logger.verbose("\t\tLoading localization file: finished")
            Logger.verbose("\t\tAnalyzing localization file: started \(file)")
            let lines = content.components(separatedBy: "\n")
            for line in lines {
                let keyValue = parseLocalizationLine(line)
                if let key = keyValue.0, let value = keyValue.1 {
                    let property = key.propertyName()
                    localizationEntries.append(LocalizationEntry(path: file, key: key, value: value, property: property))
                }
            }
            Logger.verbose("\t\tAnalyzing localization file: finished \(file)") 
        } catch {
            Logger.error("\(error)")
            content = ""
        }        
        return localizationEntries
    }
    
    func appendEntries(_ from : [LocalizationEntry], to : inout [LocalizationEntry]) {
        for entry in from {
            if LocalizationParser.contains(to, key: entry.key) {
                continue
            }
            to.append(entry)
        }
    }
    
    static func contains(_ entries : [LocalizationEntry], key : String) -> Bool {
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
        for character in line.characters {
            if character == "\"" {
                if previousCharacter != "\\" {
                    if keyStarted == false && keyFinished == false {
                        keyStarted = true
                        continue
                    }
                    if keyStarted == true && keyFinished == false {
                        keyFinished = true
                        continue
                    }
                    if keyFinished == true && valueStarted == false {
                        valueStarted = true
                        continue
                    }
                    if valueStarted == true && valueFinished == false {
                        valueFinished = true
                        continue
                    }
                }
            }
            if character == "#" && keyStarted == true && keyFinished == false {
                keyFinished = true
                continue
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
