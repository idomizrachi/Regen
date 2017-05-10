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
    var property : String
}

class LocalizationParser {
    
    func parseLocalizationFile(_ file : String) -> [LocalizationEntry] {
        var localizationEntries : [LocalizationEntry] = []
        let content : String
        do {
            content = try String(contentsOfFile: file)
            let lines = content.components(separatedBy: "\n")
            for var line in lines {                
                line = line.trimmingCharacters(in: CharacterSet.whitespaces)
                guard line.hasPrefix("\"") else {
                    continue
                }
                line.remove(at: line.startIndex)
                if let index = line.characters.index(of: "\"") {
                    var key = line.substring(to: index)
                    if let indexOfPlural = line.characters.index(of: "#") {
                        key = key.substring(to: indexOfPlural)
                    }
                    let parts = key.components(separatedBy: CharacterSet(charactersIn: ". "))
                    let property = PropertyName.propertyName(parts)
                    localizationEntries.append(LocalizationEntry(path: file, key: key, property: property))
                }
            }
        } catch {
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
}
