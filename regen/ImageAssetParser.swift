//
//  ImageAssetParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa

struct ImageAssetMetadata {
    var path : String
    var imageNamed : String
    var property : String
}

class ImageAssetParser {
    func parseImage(_ imageAsset : String) -> ImageAssetMetadata {
        var metadata = ImageAssetMetadata(path: imageAsset, imageNamed: "", property: "")
        guard var imageName = imageAsset.components(separatedBy: "/").last else {
            return metadata
        }
        imageName = imageName.substring(to: imageName.characters.index(imageName.endIndex, offsetBy: -ImageFinder.imageSuffix.characters.count))
        metadata.imageNamed = imageName
        metadata.property = imageName.propertyName()
        return metadata
    }
}
