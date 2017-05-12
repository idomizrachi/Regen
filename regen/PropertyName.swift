//
//  PropertyName.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/16/16.
//

import Foundation

extension String {
    func propertyName() -> String {
        guard self.characters.count > 0 else {
            return self
        }
        var propertyNameParts: [String] = []
        var currentToken = ""
        var isPreviousCharacterLowercased = self.characters.first!.isLowercased()
        var isPreviousCharacterUppercased = self.characters.first!.isUppercased()
        for character in self.characters {
            if character.isValidForPropertyName() == false {
                propertyNameParts.append((currentToken))
                currentToken = ""
                continue
            }
            let isScanningLowercaseString = isPreviousCharacterLowercased && character.isLowercased()
            let isScanningUppercaseString = isPreviousCharacterUppercased && character.isUppercased()
            
            if (isScanningUppercaseString == false && isScanningLowercaseString == false) {
                propertyNameParts.append(currentToken)
                currentToken = ""
            }
            currentToken += String(character)
            isPreviousCharacterLowercased = character.isLowercased()
            isPreviousCharacterUppercased = character.isUppercased()
        }
        propertyNameParts.append(currentToken)
        var propertyName = ""
        var index = 0
        var p: [String] = []
        while index < propertyNameParts.count {
            let part = propertyNameParts[index]
            if part.characters.count == 1 && index < propertyNameParts.count - 1 {
                let nextPart = propertyNameParts[index+1]
                if part.isUppercased() && nextPart.isLowercased() {
                    p.append(part + nextPart)
                    index += 1
                }
            } else {
                p.append(part)
            }
            index += 1
        }
        index = 0
        for part in p {
            if (index == 0) {
                propertyName += part.lowercased()
            } else {
                propertyName += part.capitalized
            }
            index += 1
        }
        return propertyName
    }
    
    func isLowercased() -> Bool {
        for character in self.characters {
            if character.isLowercased() == false {
                return false
            }
        }
        return true
    }
    
    func isUppercased() -> Bool {
        for character in self.characters {
            if character.isUppercased() == false {
                return false
            }
        }
        return true
    }
}

private extension Character {
    func isValidForPropertyName() -> Bool {
        return self.isLowercased() || self.isUppercased() || self.isNumeric() || self.isDelimiter()
    }
    
    func isLowercased() -> Bool {
        return self >= "a" && self <= "z"
    }
    
    func isUppercased() -> Bool {
        return self >= "A" && self <= "Z"
    }
    
    func isNumeric() -> Bool {
        return self >= "0" && self <= "9"
    }
    
    func isDelimiter() -> Bool {
        return " -_.".contains(String(self))
    }
}
