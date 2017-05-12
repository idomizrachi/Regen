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
    func validate(_ images : [ImageAssetMetadata]) -> [ValidationIssue] {
        Logger.debug("\tImages validation: started")
        var issues : [ValidationIssue] = []
        guard images.count > 1 else {
            Logger.debug("\tImages validation: finished")
            return issues
        }
        for i in 0...images.count-2 {
            for j in i+1...images.count-1 {
                if images[i].property == images[j].property {
                    issues.append(ValidationIssue(firstImage: images[i].imageNamed, secondImage: images[j].imageNamed, property: images[i].property))
                }
            }
        }
        Logger.debug("\tImages validation: finished (\(issues.count) issue\\s found)")
        return issues
    }
}
