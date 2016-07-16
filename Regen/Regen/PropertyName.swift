//
//  PropertyName.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/16/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class PropertyName {
    static func propertyName(parts : [String]) -> String {
        var propertyName = ""
        propertyName = parts[0]
        for index in 1...parts.count-1 {
            propertyName += capitalizeFirstCharacter(parts[index])
        }
        return propertyName
    }
    
    private static func capitalizeFirstCharacter(string : String) -> String {
        let capitalized = String(string[string.startIndex]).uppercaseString
        return string.stringByReplacingCharactersInRange(string.startIndex...string.startIndex,
                                                         withString: capitalized)
    }
}