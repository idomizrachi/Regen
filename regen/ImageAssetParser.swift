//
//  ImageAssetParser.swift
//  Regen
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
    
    func parseImage(_ imageAsset : String) -> ImageAssetMetadata {
        var metadata = ImageAssetMetadata(path: imageAsset, imageNamed: "", property: "")
        guard var imageName = imageAsset.components(separatedBy: "/").last else {
            return metadata
        }
        imageName = imageName.substring(to: imageName.characters.index(imageName.endIndex, offsetBy: -ImageFinder.imageSuffix.characters.count))
        metadata.imageNamed = imageName
        metadata.property = propertyName(imageName)
        return metadata
    }
    
    func propertyName(_ imageName : String) -> String {
        var parts : [String] = []
        let capitalizedImageName = imageName.capitalized
        var shouldUpperCase = false
        for character in capitalizedImageName.characters {
            if (seperators.contains(String(character))) {
                shouldUpperCase = true
                continue
            } else {
                if (shouldUpperCase) {
                    parts.append(String(character).uppercased())
                    shouldUpperCase = false
                } else {
                    parts.append(String(character))
                }
            }
        }
        return parts.joined(separator: "")
    }
}
