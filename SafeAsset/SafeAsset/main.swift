//
//  main.swift
//  SafeAsset
//
//  Created by Ido Mizrachi on 7/7/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

if (Process.arguments.contains("--version")) {
    print("\(Version.current)")
    exit(EXIT_SUCCESS)
}

let fileManager = NSFileManager.defaultManager()
let searchPath = fileManager.currentDirectoryPath

let assetsFinder = AssetsFinder(fileManager: fileManager)
let assets = assetsFinder.findAssets(inPath: searchPath)

let imageFinder = ImageFinder(fileManager: fileManager)
let imageAssetParser = ImageAssetParser()
var metadatas : [ImageAssetMetadata] = []

for asset in assets {
    let images = imageFinder.findImages(inAsset: asset)
    for image in images {
        let metadata = imageAssetParser.parseImage(image)
        metadatas.append(metadata)
    }
}

let validator = Validator()
let validationIssues = validator.validate(metadatas)
if validationIssues.count == 0 {
    let generator = ResourceesClassGenerator()
    generator.generateClass(fromImages: metadatas, generatedFile: "Images")
} else {
    for validationIssue in validationIssues {
        print("\(validationIssue.firstImage) conflicts with \(validationIssue.secondImage) for as property \(validationIssue.property)")
    }
    exit(EXIT_FAILURE)
}

exit(EXIT_SUCCESS)