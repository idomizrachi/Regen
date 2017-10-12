//
//  PropertyName.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/16/16.
//

import Foundation

private extension String {
    func isUppercased() -> Bool {
        return self == self.uppercased()
    }
    
    func isLowercased() -> Bool {
        return self == self.lowercased()
    }
}

extension String {
    func propertyName() -> String {
        if self.characters.count == 0 {
            return self
        }
        var propertyName = ""
        var tokens: [String] = []
        var currentToken = String(self[self.index(self.startIndex, offsetBy: 0)])
        var previousCharacterType = CharacterType.fromCharacter(self[self.index(self.startIndex, offsetBy: 0)])
        var isFirstToken = true
        for i in 1..<self.characters.count {
            let character = self[self.index(self.startIndex, offsetBy: i)]
            let characterType = CharacterType.fromCharacter(character)
            if character.isValidForPropertyName() {
                if characterType != previousCharacterType {
                    if currentToken.isUppercased() && currentToken.characters.count == 1 {
                    } else {
                        if isFirstToken == false {
                            currentToken = currentToken.capitalized
                        } else {
                            currentToken = currentToken.lowercased()
                            isFirstToken = false
                        }
                        tokens.append(currentToken)
                        currentToken = ""
                    }
                }
                currentToken += String(character)
            } else {
            }
            previousCharacterType = characterType
        }
        if isFirstToken == false {
            currentToken = currentToken.capitalized
        } else {
            currentToken = currentToken.lowercased()
            isFirstToken = false
        }
        tokens.append(currentToken)
        
        var index = 0
        while index < tokens.count {
            let token = tokens[index]
            if token.characters.count == 1 && token.isUppercased() && index+1 < tokens.count && token != "A" {
                propertyName += token + tokens[index+1].lowercased()
                index += 1
            } else {
                propertyName += token
            }
            index += 1
        }
        
        return propertyName
    }
}


private enum CharacterType {
    case lowercase
    case uppercase
    case other
    
    static func fromCharacter(_ character: Character) -> CharacterType {
        if character.isLowercased() {
            return .lowercase
        } else if character.isUppercased() {
            return .uppercase
        } else {
            return .other
        }
    }
}

private extension Character {
    func isValidForPropertyName() -> Bool {
        return self.isLowercased() || self.isUppercased() || self.isNumeric()
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
}
