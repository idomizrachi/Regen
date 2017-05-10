//
//  PropertyName.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/16/16.
//

import Foundation

class PropertyName {
    static func propertyName(_ parts : [String]) -> String {
        var propertyName = ""
        propertyName = parts[0]
        if (parts.count > 1) {
            for index in 1...parts.count-1 {
                propertyName += parts[index].camelcase()
            }
        }        
        return propertyName
    }
}
