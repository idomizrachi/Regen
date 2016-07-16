//
//  Validator.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Cocoa

struct ValidationIssue {
    var firstImage : String
    var secondImage : String
    var property : String
}

class ImagesValidator {
    func validate(images : [ImageAssetMetadata]) -> [ValidationIssue] {
        var issues : [ValidationIssue] = []
        guard images.count > 1 else {
            return issues
        }
        for i in 0...images.count-2 {
            for j in i+1...images.count-1 {
                if images[i].property == images[j].property {
                    issues.append(ValidationIssue(firstImage: images[i].imageNamed, secondImage: images[j].imageNamed, property: images[i].property))
                }
            }
        }
        return issues
    }
}
