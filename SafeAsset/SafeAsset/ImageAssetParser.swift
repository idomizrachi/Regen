//
//  ImageAssetParser.swift
//  SafeAsset
//
//  Created by Ido Mizrachi on 7/8/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Cocoa

struct ImageAssetMetadata {
    var path : String
    var imageNamed : String
    var property : String
}

class ImageAssetParser {
    let seperators = ["-", "_"]
    
    func parseImage(imageAsset : String) -> ImageAssetMetadata {
        var metadata = ImageAssetMetadata(path: imageAsset, imageNamed: "", property: "")
        guard var imageName = imageAsset.componentsSeparatedByString("/").last else {
            return metadata
        }
        imageName = imageName.substringToIndex(imageName.endIndex.advancedBy(-ImageFinder.imageSuffix.characters.count))
        metadata.imageNamed = imageName
        metadata.property = propertyName(imageName)
        return metadata
    }
    
    func propertyName(imageName : String) -> String {
        var parts : [String] = []
        let capitalizedImageName = capitalizeFirstCharacter(imageName)
        var shouldUpperCase = false
        for character in capitalizedImageName.characters {
            if (seperators.contains(String(character))) {
                shouldUpperCase = true
                continue
            } else {
                if (shouldUpperCase) {
                    parts.append(String(character).uppercaseString)
                    shouldUpperCase = false
                } else {
                    parts.append(String(character))
                }
            }
        }
        return parts.joinWithSeparator("")
    }
    
    func capitalizeFirstCharacter(string : String) -> String {
        let capitalized = String(string[string.startIndex]).uppercaseString
        return string.stringByReplacingCharactersInRange(string.startIndex...string.startIndex,
                                                  withString: capitalized)
    }
}
