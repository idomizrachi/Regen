//
//  LocalizationParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

struct LocalizationEntry {
    var path : String
    var key : String
    var property : String
}

class LocalizationParser {
    
    func parseLocalizationFile(file : String) -> [LocalizationEntry] {
        var localizationEntries : [LocalizationEntry] = []
        let content : String
        do {
            content = try String(contentsOfFile: file)
            let lines = content.componentsSeparatedByString("\n")
            for var line in lines {                
                line = line.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                guard line.hasPrefix("\"") else {
                    continue
                }
                line.removeAtIndex(line.startIndex)
                if let index = line.characters.indexOf("\"") {
                    var key = line.substringToIndex(index)
                    if let indexOfPlural = line.characters.indexOf("#") {
                        key = key.substringToIndex(indexOfPlural)
                    }
                    let parts = key.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ". "))
                    let property = PropertyName.propertyName(parts)
                    localizationEntries.append(LocalizationEntry(path: file, key: key, property: property))
                }
            }
        } catch {
            content = ""
        }
        return localizationEntries
    }
    
    func appendEntries(from : [LocalizationEntry], inout to : [LocalizationEntry]) {
        for entry in from {
            if LocalizationParser.contains(to, key: entry.key) {
                continue
            }
            to.append(entry)
        }
    }
    
    static func contains(entries : [LocalizationEntry], key : String) -> Bool {
        for entry in entries {
            if entry.key == key {
                return true
            }
        }
        return false
    }
}