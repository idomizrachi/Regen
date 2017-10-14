//
//  Validator.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa

struct ValidationIssue {
    var firstImage : String
    var secondImage : String
    var property : String
}

class ImagesValidator {
    func validate(_ images : [Image]) -> [ValidationIssue] {
        Logger.debug("\tImages validation: started")
        var issues : [ValidationIssue] = []
        guard images.count > 1 else {
            Logger.debug("\tImages validation: finished")
            return issues
        }
        for i in 0...images.count-2 {
            for j in i+1...images.count-1 {                
                if images[i].file.propertyName == images[j].file.propertyName {
                    if images[i].folders.last?.propertyName == images[j].folders.last?.propertyName {
                        issues.append(ValidationIssue(firstImage: images[i].file.name, secondImage: images[j].file.name, property: images[i].file.name))
                    }
                }
            }
        }
        Logger.debug("\tImages validation: finished (\(issues.count) issue\\s found)")
        return issues
    }
}
